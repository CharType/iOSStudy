//
//  main.m
//  BlockTypeDemo
//
//  Created by CharType on 2019/3/6.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

int c = 100;
static int d = 200;
void blockTypeTest(void);
void blockCopyTest(void);
void test3(void);
typedef void (^MyBlock)(void);

MyBlock block10;
//struct __Block_byref_age_0 {
//    void *__isa;// 8
//    struct __Block_byref_age_0 *__forwarding; // 8
//    int __flags; // 4
//    int __size;// 4
//    int age;
//};

struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(void);
    void (*dispose)(void);
};

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
//    struct __Block_byref_age_0 *age;
};


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // block类型demo
//        blockTypeTest();
        
        // ARC下会自动进行copy的Demo
        test3();
        
        // block多次调用了copydemo
//        blockCopyTest();
        
    }
    return 0;
}

void blockTypeTest(){
    int autoAge = 20;
    static int staticAge = 30;
    // 没有访问局部变量的block类型
    void (^block1)(void) = ^{
        NSLog(@"hello");
    };
    NSLog(@"-----没有访问局部变量的block类型--------");
    NSLog(@"%@", [block1 class]); //  __NSGlobalBlock__
    NSLog(@"%@", [[block1 class] superclass]); // __NSGlobalBlock
    NSLog(@"%@", [[[block1 class] superclass] superclass]); //NSBlock
    NSLog(@"%@", [[[[block1 class] superclass] superclass] superclass]); // NSObject
    NSLog(@"block地址：NSGlobalBlock - %@", block1);
    // 输出 block地址：NSGlobalBlock - <__NSGlobalBlock__: 0x100002090>
    NSLog(@"static局部变量的存储区域：%p", &staticAge);
    // 输出 static局部变量的存储区域：0x1000026b4
    
    NSObject *object = [[NSObject alloc] init];
    NSLog(@"%@",object);
    // 0x1030069c0
    
    
    Class block1Class = object_getClass(block1);
    NSLog(@"%@",block1Class);
    // 输出__NSGlobalBlock__
    Class block1MetaClass = object_getClass(block1Class);
    NSLog(@"%@ isMetaClass %d",block1MetaClass,class_isMetaClass(block1MetaClass));
    //输出 __NSGlobalBlock__ isMetaClass 1
    
    
    // 访问局部变量的block类型
    int a = 10;
    void (^block2)(void) = ^{
        NSLog(@"hello a = %d", a);
        NSLog(@"hello c = %d", c);
    };
    NSLog(@"-----访问局部变量的block类型--------");
    NSLog(@"%@", [block2 class]); //__NSMallocBlock__
    NSLog(@"%@", [[block2 class] superclass]);//__NSMallocBlock
    NSLog(@"%@", [[[block2 class] superclass] superclass]);//NSBlock
    NSLog(@"%@", [[[[block2 class] superclass] superclass] superclass]);//NSObject
    NSLog(@"block地址：NSMallocBlock - %@", block2);
    // 输出 block地址：NSMallocBlock - <__NSMallocBlock__: 0x1005005d0>
    
    int age = 20;
    NSLog(@"%@",[^{
        NSLog(@"hello, %d", age);
    } class]); // __NSStackBlock__
    
    
    NSLog(@"block地址：NSStackBlock - %@ auto变量的存储地址是：%p",^{
        NSLog(@"hello, %d", age);
    }, &autoAge);
    // 输出 block地址：NSStackBlock - <__NSStackBlock__: 0x7ffeefbff4b8> auto变量的存储地址是：0x7ffeefbff55c
    
    // 访问静态变量的block类型
    static int b = 10;
    void (^block3)(void) = ^{
        NSLog(@"hello b = %d", b);
    };
    NSLog(@"-----访问静态变量的block类型--------");
    NSLog(@"%@", [block3 class]);//__NSGlobalBlock__
    NSLog(@"%@", [[block3 class] superclass]);//__NSGlobalBlock
    NSLog(@"%@", [[[block3 class] superclass] superclass]);//NSBlock
    NSLog(@"%@", [[[[block3 class] superclass] superclass] superclass]);//NSObject
    
    void (^block4)(void) = ^{
        NSLog(@"hello c = %d, d = %d", c, d);
    };
    NSLog(@"-----访问全局变量的block类型--------");
    NSLog(@"%@", [block4 class]);//__NSGlobalBlock__
    NSLog(@"%@", [[block4 class] superclass]);// __NSGlobalBlock
    NSLog(@"%@", [[[block4 class] superclass] superclass]);// NSBlock
    NSLog(@"%@", [[[[block4 class] superclass] superclass] superclass]);// NSObject
    
}


MyBlock tets4 () {
    int a = 20;
   __block int b = 20;
    b = b+10;
    
    MyBlock block = ^{
        NSLog(@"%d", b);
    };
    NSLog(@"%d",b);
    
    NSLog(@"dasad");
    return block;
}

void test3() {
    int a = 10;
    MyBlock block = ^{
        NSLog(@"%d", a);
    };
    NSLog(@"%@", [block class]);
    // MRC: __NSStackBlock__
    // ARC: __NSMallocBlock__
    
    //    [block release];
    
    MyBlock block1 = tets4();
    block1();
    NSLog(@"%@", [block1 class]);
    // MRC: __NSStackBlock__
    // ARC: __NSMallocBlock__
    
    int age = 20;
    NSLog(@"%@",[^{
        NSLog(@"hello, %d", age);
    } class]);
    // __NSStackBlock__
}

void blockCopyTest() {

    // 在MRC下
    // 没有访问局部变量的block类型
    MyBlock block1 = ^{
        NSLog(@"hello");
    };
    NSLog(@"block1 class %@", [block1 class]);
    // __NSGlobalBlock__
    NSLog(@"NSGlobalBlockl类型的block copy之后的类型是:");
    NSLog(@"block1 copy class =  %@", [[block1 copy] class]);
    // __NSGlobalBlock__
    
    int a = 10;
    MyBlock block2 = ^{
        NSLog(@"a = %d", a);
    };
    NSLog(@"block2 %@",block2);
    // block2 <__NSMallocBlock__: 0x10060da60>
    NSLog(@"block2:%@ block2 class %@",block2, [block2 class]);
    // block2:<__NSMallocBlock__: 0x10060da60> block2 class __NSMallocBlock__
    NSLog(@"NSStackBlock类型的block copy之后的类型是:");
    NSLog(@"block2 copy class %@", [[block2 copy] class]);
    // block2 copy class __NSMallocBlock
    
    
    MyBlock block3 = [block2 copy];
    NSLog(@"block3 class %@", [block3 class]);
    NSLog(@"NSMallocBlock类型的block copy之后的类型是:");
    NSLog(@"block3 copy class %@", [[block3 copy] class]);
    // block3 copy class __NSMallocBlock__
    
    
    MyBlock block4 = [block3 copy];
    MyBlock block5 = [block4 copy];
    MyBlock block6 = [block5 copy];
    MyBlock block7 = [block6 copy];
    NSLog(@"block2 %@",block2);
    // block2 <__NSMallocBlock__: 0x10072da50>
    NSLog(@"block3 %@",block3);
    // block3 <__NSMallocBlock__: 0x10072da50>
    NSLog(@"block4 %@",block4);
    // block4 <__NSMallocBlock__: 0x10072da50>
    NSLog(@"block5 %@",block5);
    // block5 <__NSMallocBlock__: 0x10072da50>
    NSLog(@"block6 %@",block6);
    // block6 <__NSMallocBlock__: 0x10072da50>
    NSLog(@"block7 %@",block7);
    // block7 <__NSMallocBlock__: 0x10072da50>
    
    
//    NSLog(@"block3 retainCount %ld", [block3 retainCount]);
//    NSLog(@"block2 retainCount %ld", [block2 retainCount]);
//    NSLog(@"block3 retainCount %ld", [[block3 copy] retainCount]);
//    NSLog(@"block3 retainCount %ld", [[[block3 copy] copy] retainCount]);
//    NSLog(@"block3 retainCount %ld", [[[[block3 copy] copy] copy] retainCount]);
//
//    MyBlock block8 = [[[[[block3 copy] copy] copy] copy] copy];
//    MyBlock block9 = [block8 copy];
//    NSLog(@"block8 retainCount %ld", [block8 retainCount]);
//    NSLog(@"block9 retainCount %ld", [block9 retainCount]);
//    block10 = [[[[[block3 copy] copy] copy] copy] copy];
//    NSLog(@"block10 retainCount %ld", [block10 retainCount]);
    
    
};

