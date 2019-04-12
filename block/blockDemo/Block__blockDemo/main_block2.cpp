#pragma clang assume_nonnull end

//__block int age = 10;
//__block NSObject *object = [[NSObject alloc] init];
//MyBlock block = ^{
//    age = 20;
//    NSLog(@"%d",age);
//    NSLog(@"%@",object);
//};


#define __OFFSETOFIVAR__(TYPE, MEMBER) ((long long) &((TYPE *)0)->MEMBER)

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

static void __Block_byref_id_object_copy_131(void *dst, void *src) {
    // +40
    _Block_object_assign((char*)dst + 40, *(void * *) ((char*)src + 40), 131);
}
static void __Block_byref_id_object_dispose_131(void *src) {
    _Block_object_dispose(*(void * *) ((char*)src + 40), 131);
}

typedef void (*MyBlock)(void);
struct __Block_byref_age_0 {
    void *__isa;
    __Block_byref_age_0 *__forwarding;
    int __flags;
    int __size;
    int age;
};
struct __Block_byref_object_1 {
    void *__isa; // 8
    __Block_byref_object_1 *__forwarding; // 8
    int __flags; //4
    int __size; //4
    // 使用 __block修饰的OC对象 会有这两个函数
    void (*__Block_byref_id_object_copy)(void*, void*); //8
    void (*__Block_byref_id_object_dispose)(void*); // 8
    NSObject *__strong object;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    __Block_byref_age_0 *age; // by ref
    __Block_byref_object_1 *object; // by ref
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_age_0 *_age, __Block_byref_object_1 *_object, int flags=0) : age(_age->__forwarding), object(_object->__forwarding) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    __Block_byref_age_0 *age = __cself->age; // bound by ref
    __Block_byref_object_1 *object = __cself->object; // bound by ref
    
    (age->__forwarding->age) = 20;
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_1fb0c2_mi_0,(age->__forwarding->age));
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_1fb0c2_mi_1,(object->__forwarding->object));
}
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->age, (void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);_Block_object_assign((void*)&dst->object, (void*)src->object, 8/*BLOCK_FIELD_IS_BYREF*/);}

static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);_Block_object_dispose((void*)src->object, 8/*BLOCK_FIELD_IS_BYREF*/);}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
    void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};
int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
        
        //__block int age = 10;
        __attribute__((__blocks__(byref))) __Block_byref_age_0 age = {
            (void*)0,
            (__Block_byref_age_0 *)&age,
            0,
            sizeof(__Block_byref_age_0),
            10
        };
        //__block NSObject *object = [[NSObject alloc] init];
        __attribute__((__blocks__(byref))) __Block_byref_object_1 object = {
            (void*)0,
            (__Block_byref_object_1 *)&object,
            33554432,
            sizeof(__Block_byref_object_1),
            __Block_byref_id_object_copy_131,
            __Block_byref_id_object_dispose_131,
            ((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("alloc")), sel_registerName("init"))
        };
        
        // 定义block
        MyBlock block = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_age_0 *)&age, (__Block_byref_object_1 *)&object, 570425344));
        // 调用block
        ((void (*)(__block_impl *))((__block_impl *)block1)->FuncPtr)((__block_impl *)block1);
        
        
    }
    return 0;
}
