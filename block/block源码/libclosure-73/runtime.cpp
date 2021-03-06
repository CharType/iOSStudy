/*
 * runtime.cpp
 * libclosure
 *
 * Copyright (c) 2008-2010 Apple Inc. All rights reserved.
 *
 * @APPLE_LLVM_LICENSE_HEADER@
 */


#include "Block_private.h"
#include <platform/string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <dlfcn.h>
#include <os/assumes.h>
#ifndef os_assumes
#define os_assumes(_x) os_assumes(_x)
#endif
#ifndef os_assert
#define os_assert(_x) os_assert(_x)
#endif

#define memmove _platform_memmove

#if TARGET_OS_WIN32
#define _CRT_SECURE_NO_WARNINGS 1
#include <windows.h>
static __inline bool OSAtomicCompareAndSwapLong(long oldl, long newl, long volatile *dst) 
{ 
    // fixme barrier is overkill -- see objc-os.h
    long original = InterlockedCompareExchange(dst, newl, oldl);
    return (original == oldl);
}

static __inline bool OSAtomicCompareAndSwapInt(int oldi, int newi, int volatile *dst) 
{ 
    // fixme barrier is overkill -- see objc-os.h
    int original = InterlockedCompareExchange(dst, newi, oldi);
    return (original == oldi);
}
#else
#define OSAtomicCompareAndSwapLong(_Old, _New, _Ptr) __sync_bool_compare_and_swap(_Ptr, _Old, _New)
#define OSAtomicCompareAndSwapInt(_Old, _New, _Ptr) __sync_bool_compare_and_swap(_Ptr, _Old, _New)
#endif


/*******************************************************************************
Internal Utilities
********************************************************************************/

static int32_t latching_incr_int(volatile int32_t *where) {
    while (1) {
        int32_t old_value = *where;
        if ((old_value & BLOCK_REFCOUNT_MASK) == BLOCK_REFCOUNT_MASK) {
            return BLOCK_REFCOUNT_MASK;
        }
        if (OSAtomicCompareAndSwapInt(old_value, old_value+2, where)) {
            return old_value+2;
        }
    }
}

static bool latching_incr_int_not_deallocating(volatile int32_t *where) {
    while (1) {
        int32_t old_value = *where;
        if (old_value & BLOCK_DEALLOCATING) {
            // if deallocating we can't do this
            return false;
        }
        if ((old_value & BLOCK_REFCOUNT_MASK) == BLOCK_REFCOUNT_MASK) {
            // if latched, we're leaking this block, and we succeed
            return true;
        }
        if (OSAtomicCompareAndSwapInt(old_value, old_value+2, where)) {
            // otherwise, we must store a new retained value without the deallocating bit set
            return true;
        }
    }
}


// return should_deallocate?
static bool latching_decr_int_should_deallocate(volatile int32_t *where) {
    while (1) {
        int32_t old_value = *where;
        if ((old_value & BLOCK_REFCOUNT_MASK) == BLOCK_REFCOUNT_MASK) {
            return false; // latched high
        }
        if ((old_value & BLOCK_REFCOUNT_MASK) == 0) {
            return false;   // underflow, latch low
        }
        int32_t new_value = old_value - 2;
        bool result = false;
        if ((old_value & (BLOCK_REFCOUNT_MASK|BLOCK_DEALLOCATING)) == 2) {
            new_value = old_value - 1;
            result = true;
        }
        if (OSAtomicCompareAndSwapInt(old_value, new_value, where)) {
            return result;
        }
    }
}


/**************************************************************************
Framework callback functions and their default implementations.
***************************************************************************/
#if !TARGET_OS_WIN32
#pragma mark Framework Callback Routines
#endif

static void _Block_retain_object_default(const void *ptr __unused) { }

static void _Block_release_object_default(const void *ptr __unused) { }

static void _Block_destructInstance_default(const void *aBlock __unused) {}

static void (*_Block_retain_object)(const void *ptr) = _Block_retain_object_default;
static void (*_Block_release_object)(const void *ptr) = _Block_release_object_default;
static void (*_Block_destructInstance) (const void *aBlock) = _Block_destructInstance_default;


/**************************************************************************
Callback registration from ObjC runtime and CoreFoundation
***************************************************************************/

void _Block_use_RR2(const Block_callbacks_RR *callbacks) {
    _Block_retain_object = callbacks->retain;
    _Block_release_object = callbacks->release;
    _Block_destructInstance = callbacks->destructInstance;
}

/****************************************************************************
Accessors for block descriptor fields
*****************************************************************************/
#if 0
static struct Block_descriptor_1 * _Block_descriptor_1(struct Block_layout *aBlock)
{
    return aBlock->descriptor;
}
#endif

static struct Block_descriptor_2 * _Block_descriptor_2(struct Block_layout *aBlock)
{
    if (! (aBlock->flags & BLOCK_HAS_COPY_DISPOSE)) return NULL;
    uint8_t *desc = (uint8_t *)aBlock->descriptor;
    desc += sizeof(struct Block_descriptor_1);
    return (struct Block_descriptor_2 *)desc;
}

static struct Block_descriptor_3 * _Block_descriptor_3(struct Block_layout *aBlock)
{
    if (! (aBlock->flags & BLOCK_HAS_SIGNATURE)) return NULL;
    uint8_t *desc = (uint8_t *)aBlock->descriptor;
    desc += sizeof(struct Block_descriptor_1);
    if (aBlock->flags & BLOCK_HAS_COPY_DISPOSE) {
        desc += sizeof(struct Block_descriptor_2);
    }
    return (struct Block_descriptor_3 *)desc;
}

static void _Block_call_copy_helper(void *result, struct Block_layout *aBlock)
{
    struct Block_descriptor_2 *desc = _Block_descriptor_2(aBlock);
    if (!desc) return;

    (*desc->copy)(result, aBlock); // do fixup
}

static void _Block_call_dispose_helper(struct Block_layout *aBlock)
{
    struct Block_descriptor_2 *desc = _Block_descriptor_2(aBlock);
    if (!desc) return;

    (*desc->dispose)(aBlock);
}

/*******************************************************************************
Internal Support routines for copying
********************************************************************************/

#if !TARGET_OS_WIN32
#pragma mark Copy/Release support
#endif

// Copy, or bump refcount, of a block.  If really copying, call the copy helper if present.
void *_Block_copy(const void *arg) {
    struct Block_layout *aBlock;
    // 如果参数传null 直接返回
    if (!arg) return NULL;
    
    // The following would be better done as a switch statement
    // 将block对象转换成 Block_layout
    aBlock = (struct Block_layout *)arg;
    
    if (aBlock->flags & BLOCK_NEEDS_FREE) {
        // latches on high
        // 如果block已经在的堆上面
        //retainCount 增加
        latching_incr_int(&aBlock->flags);
        return aBlock;
    }
    // 如果是GLOBAL类型的block 直接reurn
    else if (aBlock->flags & BLOCK_IS_GLOBAL) {
        return aBlock;
    }
    else {
        // 否则block是在栈上的block
        // Its a stack block.  Make a copy.
        // 在堆上申请block需要存储的指定大小内存空间
        struct Block_layout *result =
            (struct Block_layout *)malloc(aBlock->descriptor->size);
        // 内存申请失败直接return;
        if (!result) return NULL;
        // 将函数的入参 NSStackBlock 数据复制到新申请的堆内存上
        memmove(result, aBlock, aBlock->descriptor->size); // bitcopy first
#if __has_feature(ptrauth_calls)
        // Resign the invoke pointer as it uses address authentication.
        result->invoke = aBlock->invoke;
#endif
        // reset refcount // 没看懂
        result->flags &= ~(BLOCK_REFCOUNT_MASK|BLOCK_DEALLOCATING);    // XXX not needed
        // 给block内部的标志位赋值  BLOCK_NEEDS_FREE（表示block已经在堆上了）  并增加retainCount
        result->flags |= BLOCK_NEEDS_FREE | 2;  // logical refcount 1
        // _Block_call_copy_helper 这个函数会检查block结构体中是否有copy函数 如果有就调用block内部的copy函数 (最终会调用这个函数 _Block_object_assign)
        _Block_call_copy_helper(result, aBlock);
        // Set isa last so memory analysis tools see a fully-initialized object.
        // 修改block的类型
        result->isa = _NSConcreteMallocBlock;
        return result;
    }
}


// Runtime entry points for maintaining the sharing knowledge of byref data blocks.

// A closure has been copied and its fixup routine is asking us to fix up the reference to the shared byref data
// Closures that aren't copied must still work, so everyone always accesses variables after dereferencing the forwarding ptr.
// We ask if the byref pointer that we know about has already been copied to the heap, and if so, increment and return it.
// Otherwise we need to copy it and update the stack forwarding pointer
// __block变量的copy
static struct Block_byref *_Block_byref_copy(const void *arg) {
    struct Block_byref *src = (struct Block_byref *)arg;

    if ((src->forwarding->flags & BLOCK_REFCOUNT_MASK) == 0) {
        // src points to stack
        // 申请指定的内存空间
        struct Block_byref *copy = (struct Block_byref *)malloc(src->size);
        // 复制数据
        copy->isa = NULL;
        // byref value 4 is logical refcount of 2: one for caller, one for stack
        // 标记已经copy在堆上，引用计数器直接增加
        copy->flags = src->flags | BLOCK_BYREF_NEEDS_FREE | 4;
        // 将堆空间__block变量的forwarding指针变量指向自己
        copy->forwarding = copy; // patch heap copy to point to itself
        // 将栈空间__block变量的forwarding指针指向堆空间__block变量的地址
        src->forwarding = copy;  // patch stack to point to heap copy
        // 赋值block的size
        copy->size = src->size;

        if (src->flags & BLOCK_BYREF_HAS_COPY_DISPOSE) {
            // Trust copy helper to copy everything of interest
            // If more than one field shows up in a byref block this is wrong XXX
            struct Block_byref_2 *src2 = (struct Block_byref_2 *)(src+1);
            struct Block_byref_2 *copy2 = (struct Block_byref_2 *)(copy+1);
            // 复制copy函数地址
            copy2->byref_keep = src2->byref_keep;
            // 复制dispose函数地址
            copy2->byref_destroy = src2->byref_destroy;

            if (src->flags & BLOCK_BYREF_LAYOUT_EXTENDED) {
                struct Block_byref_3 *src3 = (struct Block_byref_3 *)(src2+1);
                struct Block_byref_3 *copy3 = (struct Block_byref_3*)(copy2+1);
                // __block封装的对象的指针
                copy3->layout = src3->layout;
            }
            // 调用__block内部的copy函数
            (*src2->byref_keep)(copy, src);
        }
        else {
            // Bitwise copy.
            // This copy includes Block_byref_3, if any.
            memmove(copy+1, src+1, src->size - sizeof(*src));
        }
    }
    // __block变量已经标记需要释放， 直接处理retainCount
    else if ((src->forwarding->flags & BLOCK_BYREF_NEEDS_FREE) == BLOCK_BYREF_NEEDS_FREE) {
        latching_incr_int(&src->forwarding->flags);
    }
    
    // 返回栈区block上的forwarding的指针。
    return src->forwarding;
}

// __block变量的release
static void _Block_byref_release(const void *arg) {
    // 类型转换
    struct Block_byref *byref = (struct Block_byref *)arg;

    // dereference the forwarding pointer since the compiler isn't doing this anymore (ever?)
    // 获取forwarding指针 如果传进来的是栈区block，保证获取到的是copy过后的block地址
    byref = byref->forwarding;
    
    if (byref->flags & BLOCK_BYREF_NEEDS_FREE) {
        // 如果这个block是在存储的z堆区
        int32_t refcount = byref->flags & BLOCK_REFCOUNT_MASK;
        os_assert(refcount);
        // latching_decr_int_should_deallocate() 返回是否需要释放 会使retainCount减少
        if (latching_decr_int_should_deallocate(&byref->flags)) {
            if (byref->flags & BLOCK_BYREF_HAS_COPY_DISPOSE) {
                // 如果有dispose函数，调用dispose函数
                struct Block_byref_2 *byref2 = (struct Block_byref_2 *)(byref+1);
                (*byref2->byref_destroy)(byref);
            }
            // 释放这个__block对象
            free(byref);
        }
    }
}


/************************************************************
 *
 * API supporting SPI
 * _Block_copy, _Block_release, and (old) _Block_destroy
 *
 ***********************************************************/

#if !TARGET_OS_WIN32
#pragma mark SPI/API
#endif

// block释放过程
// API entry point to release a copied Block
void _Block_release(const void *arg) {
    // 将block转换为 Block_layout指针
    struct Block_layout *aBlock = (struct Block_layout *)arg;
    // 转换结果为null直接return;
    if (!aBlock) return;
    //如果block是global类型, 不需要做free
    if (aBlock->flags & BLOCK_IS_GLOBAL) return;
    // 如果block标志位标记结果不在堆上， 不需要做free 直接return
    if (! (aBlock->flags & BLOCK_NEEDS_FREE)) return;

    // latching_decr_int_should_deallocate() 返回是否需要释放 会使retainCount减少
    if (latching_decr_int_should_deallocate(&aBlock->flags)) {
        // 调用block结构体内部的的dispose函数
        _Block_call_dispose_helper(aBlock);
        _Block_destructInstance(aBlock);
        //释放block
        free(aBlock);
    }
}

bool _Block_tryRetain(const void *arg) {
    struct Block_layout *aBlock = (struct Block_layout *)arg;
    return latching_incr_int_not_deallocating(&aBlock->flags);
}

bool _Block_isDeallocating(const void *arg) {
    struct Block_layout *aBlock = (struct Block_layout *)arg;
    return (aBlock->flags & BLOCK_DEALLOCATING) != 0;
}


/************************************************************
 *
 * SPI used by other layers
 *
 ***********************************************************/

size_t Block_size(void *aBlock) {
    return ((struct Block_layout *)aBlock)->descriptor->size;
}

bool _Block_use_stret(void *aBlock) {
    struct Block_layout *layout = (struct Block_layout *)aBlock;

    int requiredFlags = BLOCK_HAS_SIGNATURE | BLOCK_USE_STRET;
    return (layout->flags & requiredFlags) == requiredFlags;
}

// Checks for a valid signature, not merely the BLOCK_HAS_SIGNATURE bit.
bool _Block_has_signature(void *aBlock) {
    return _Block_signature(aBlock) ? true : false;
}

const char * _Block_signature(void *aBlock)
{
    struct Block_layout *layout = (struct Block_layout *)aBlock;
    struct Block_descriptor_3 *desc3 = _Block_descriptor_3(layout);
    if (!desc3) return NULL;

    return desc3->signature;
}

const char * _Block_layout(void *aBlock)
{
    // Don't return extended layout to callers expecting old GC layout
    struct Block_layout *layout = (struct Block_layout *)aBlock;
    if (layout->flags & BLOCK_HAS_EXTENDED_LAYOUT) return NULL;

    struct Block_descriptor_3 *desc3 = _Block_descriptor_3(layout);
    if (!desc3) return NULL;

    return desc3->layout;
}

const char * _Block_extended_layout(void *aBlock)
{
    // Don't return old GC layout to callers expecting extended layout
    struct Block_layout *layout = (struct Block_layout *)aBlock;
    if (! (layout->flags & BLOCK_HAS_EXTENDED_LAYOUT)) return NULL;

    struct Block_descriptor_3 *desc3 = _Block_descriptor_3(layout);
    if (!desc3) return NULL;

    // Return empty string (all non-object bytes) instead of NULL 
    // so callers can distinguish "empty layout" from "no layout".
    if (!desc3->layout) return "";
    else return desc3->layout;
}

#if !TARGET_OS_WIN32
#pragma mark Compiler SPI entry points
#endif

    
/*******************************************************

Entry points used by the compiler - the real API!


A Block can reference four different kinds of things that require help when the Block is copied to the heap.
1) C++ stack based objects
2) References to Objective-C objects
3) Other Blocks
4) __block variables

In these cases helper functions are synthesized by the compiler for use in Block_copy and Block_release, called the copy and dispose helpers.  The copy helper emits a call to the C++ const copy constructor for C++ stack based objects and for the rest calls into the runtime support function _Block_object_assign.  The dispose helper has a call to the C++ destructor for case 1 and a call into _Block_object_dispose for the rest.

The flags parameter of _Block_object_assign and _Block_object_dispose is set to
    * BLOCK_FIELD_IS_OBJECT (3), for the case of an Objective-C Object,
    * BLOCK_FIELD_IS_BLOCK (7), for the case of another Block, and
    * BLOCK_FIELD_IS_BYREF (8), for the case of a __block variable.
If the __block variable is marked weak the compiler also or's in BLOCK_FIELD_IS_WEAK (16)

So the Block copy/dispose helpers should only ever generate the four flag values of 3, 7, 8, and 24.

When  a __block variable is either a C++ object, an Objective-C object, or another Block then the compiler also generates copy/dispose helper functions.  Similarly to the Block copy helper, the "__block" copy helper (formerly and still a.k.a. "byref" copy helper) will do a C++ copy constructor (not a const one though!) and the dispose helper will do the destructor.  And similarly the helpers will call into the same two support functions with the same values for objects and Blocks with the additional BLOCK_BYREF_CALLER (128) bit of information supplied.

So the __block copy/dispose helpers will generate flag values of 3 or 7 for objects and Blocks respectively, with BLOCK_FIELD_IS_WEAK (16) or'ed as appropriate and always 128 or'd in, for the following set of possibilities:
    __block id                   128+3       (0x83)
    __block (^Block)             128+7       (0x87)
    __weak __block id            128+3+16    (0x93)
    __weak __block (^Block)      128+7+16    (0x97)
        

********************************************************/

//
// When Blocks or Block_byrefs hold objects then their copy routine helpers use this entry point
// to do the assignment.
//
void _Block_object_assign(void *destArg, const void *object, const int flags) {
    const void **dest = (const void **)destArg;
    switch (os_assumes(flags & BLOCK_ALL_COPY_DISPOSE_FLAGS)) {
      case BLOCK_FIELD_IS_OBJECT:
        /*******
        id object = ...;
        [^{ object; } copy];
        ********/
        // 如果是OC对象 持有这个指针
        _Block_retain_object(object);
        *dest = object;
        break;

      case BLOCK_FIELD_IS_BLOCK:
        /*******
        void (^object)(void) = ...;
        [^{ object; } copy];
        ********/
        // 如果是Block对象 直接进行block的copy函数调用
        *dest = _Block_copy(object);
        break;
    
      case BLOCK_FIELD_IS_BYREF | BLOCK_FIELD_IS_WEAK:
      case BLOCK_FIELD_IS_BYREF:
        /*******
         // copy the onstack __block container to the heap
         // Note this __weak is old GC-weak/MRC-unretained.
         // ARC-style __weak is handled by the copy helper directly.
         __block ... x;
         __weak __block ... x;
         [^{ x; } copy];
         ********/
        // 在MRC下不会持有这个对象 因为MRC下使用的是 MRC-unretained
        // 如果是__blockb对象，直接进行 _Block_byref_copy函数调用
        *dest = _Block_byref_copy(object);
        break;
        
      case BLOCK_BYREF_CALLER | BLOCK_FIELD_IS_OBJECT:
      case BLOCK_BYREF_CALLER | BLOCK_FIELD_IS_BLOCK:
        /*******
         // copy the actual field held in the __block container
         // Note this is MRC unretained __block only. 
         // ARC retained __block is handled by the copy helper directly.
         __block id object;
         __block void (^object)(void);
         [^{ object; } copy];
         ********/
        // 其他类型 直接赋值
        *dest = object;
        break;

      case BLOCK_BYREF_CALLER | BLOCK_FIELD_IS_OBJECT | BLOCK_FIELD_IS_WEAK:
      case BLOCK_BYREF_CALLER | BLOCK_FIELD_IS_BLOCK  | BLOCK_FIELD_IS_WEAK:
        /*******
         // copy the actual field held in the __block container
         // Note this __weak is old GC-weak/MRC-unretained.
         // ARC-style __weak is handled by the copy helper directly.
         __weak __block id object;
         __weak __block void (^object)(void);
         [^{ object; } copy];
         ********/
            // 其他类型 直接赋值
        *dest = object;
        break;

      default:
        break;
    }
}

// When Blocks or Block_byrefs hold objects their destroy helper routines call this entry point
// to help dispose of the contents
void _Block_object_dispose(const void *object, const int flags) {
    switch (os_assumes(flags & BLOCK_ALL_COPY_DISPOSE_FLAGS)) {
      case BLOCK_FIELD_IS_BYREF | BLOCK_FIELD_IS_WEAK:
      case BLOCK_FIELD_IS_BYREF:
        // get rid of the __block data structure held in a Block
        // 如果是__block类型 调用 __block 的 _Block_byref_release 释放
        _Block_byref_release(object);
        break;
      case BLOCK_FIELD_IS_BLOCK:
            // 如果是blcok类型 调用block的释放
        _Block_release(object);
        break;
      case BLOCK_FIELD_IS_OBJECT:
            // 如果是OC Object类型 调用更深一层次的系统的方法
        _Block_release_object(object);
        break;
      case BLOCK_BYREF_CALLER | BLOCK_FIELD_IS_OBJECT:
      case BLOCK_BYREF_CALLER | BLOCK_FIELD_IS_BLOCK:
      case BLOCK_BYREF_CALLER | BLOCK_FIELD_IS_OBJECT | BLOCK_FIELD_IS_WEAK:
      case BLOCK_BYREF_CALLER | BLOCK_FIELD_IS_BLOCK  | BLOCK_FIELD_IS_WEAK:
            // 其他 不处理
        break;
      default:
        break;
    }
}


// Workaround for <rdar://26015603> dylib with no __DATA segment fails to rebase
__attribute__((used))
static int let_there_be_data = 42;
