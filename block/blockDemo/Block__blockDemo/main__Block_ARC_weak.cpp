#pragma clang assume_nonnull end

#define __OFFSETOFIVAR__(TYPE, MEMBER) ((long long) &((TYPE *)0)->MEMBER)
static void __Block_byref_id_object_copy_131(void *dst, void *src) {
    _Block_object_assign((char*)dst + 40, *(void * *) ((char*)src + 40), 131);
}
static void __Block_byref_id_object_dispose_131(void *src) {
    _Block_object_dispose(*(void * *) ((char*)src + 40), 131);
}


struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

typedef void (*MyBlock)(void);


struct __Block_byref_weakObject_0 {
    void *__isa; // 8
    __Block_byref_weakObject_0 *__forwarding; // 8
    int __flags; // 4
    int __size; // 4
    void (*__Block_byref_id_object_copy)(void*, void*); // 8
    void (*__Block_byref_id_object_dispose)(void*); // 8
    NSObject *__weak weakObject;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    __Block_byref_weakObject_0 *weakObject; // by ref
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_weakObject_0 *_weakObject, int flags=0) : weakObject(_weakObject->__forwarding) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    __Block_byref_weakObject_0 *weakObject = __cself->weakObject; // bound by ref
    
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_233283_mi_0,(weakObject->__forwarding->weakObject));
}
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {
    _Block_object_assign((void*)&dst->weakObject,
                         (void*)src->weakObject,
                         8/*BLOCK_FIELD_IS_BYREF*/
                         );
}

static void __main_block_dispose_0(struct __main_block_impl_0*src) {
    _Block_object_dispose((void*)src->weakObject, 8/*BLOCK_FIELD_IS_BYREF*/);
    
}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
    void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = {
    0,
    sizeof(struct __main_block_impl_0),
    __main_block_copy_0,
    __main_block_dispose_0
};

int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
        
        // NSObject *object = [[NSObject alloc] init];
        NSObject *object = ((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("alloc")), sel_registerName("init"));
        __weak NSObject *weakObject = object;
        __Block_byref_weakObject_0 weakObject = {
            &weakObject,
            33554432,
            sizeof(__Block_byref_weakObject_0),
            __Block_byref_id_object_copy_131,
            __Block_byref_id_object_dispose_131,
            object
            
        };
        
        /*处理之前
         * __attribute__((__blocks__(byref))) __attribute__((objc_ownership(weak))) __Block_byref_weakObject_0 weakObject = {(void*)0,(__Block_byref_weakObject_0 *)&weakObject, 33554432, sizeof(__Block_byref_weakObject_0), __Block_byref_id_object_copy_131, __Block_byref_id_object_dispose_131, object};
         */
        MyBlock block = &__main_block_impl_0(
                                             __main_block_func_0,
                                             &__main_block_desc_0_DATA,
                                             &weakObject,
                                             570425344);
        
        ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
        
    }
    return 0;
}
