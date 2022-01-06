

#pragma clang assume_nonnull end

//__block int age = 10;
//MyBlock block1 = ^{
//    age = 20;
//    NSLog(@"%d",age);
//};
//block1();
//age = 30;

typedef void (*MyBlock)(void);


struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

//生成的__block对象的结构体
struct __Block_byref_age_0 {
  void *__isa;
__Block_byref_age_0 *__forwarding;  //  __forwarding 指针指向自己
 int __flags;
 int __size; // 结构体的大小
 int age; // 最终访问的变量的值
};

// 生成的block的结构体
struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  __Block_byref_age_0 *age; // by ref  block捕获的 __Block_byref_age_0 对象
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_age_0 *_age, int flags=0) : age(_age->__forwarding) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
  __Block_byref_age_0 *age = __cself->age; // bound by ref
            //    age = 20;
            (age->__forwarding->age) = 20;
            //    NSLog(@"%d",age);
            NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_e106a7_mi_0,(age->__forwarding->age));
        }
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {
    _Block_object_assign((void*)&dst->age, (void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);
}

static void __main_block_dispose_0(struct __main_block_impl_0*src) {
    _Block_object_dispose((void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);
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
        // //__block int age = 10;
        // 声明了 __Block_byref_age_0 这样的一个结构体
         __Block_byref_age_0 age = {0,&age, 0, sizeof(__Block_byref_age_0), 10};
//        __attribute__((__blocks__(byref))) __Block_byref_age_0 age = {(void*)0,(__Block_byref_age_0 *)&age, 0, sizeof(__Block_byref_age_0), 10};
        
        MyBlock block1 = &__main_block_impl_0(__main_block_func_0, &__main_block_desc_0_DATA, &age, 570425344);
        
        //
//        MyBlock block1 = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_age_0 *)&age, 570425344));
        
        //block1();
        ((void (*)(__block_impl *))((__block_impl *)block1)->FuncPtr)((__block_impl *)block1);
        // age = 30  访问变量的值
        (age.__forwarding->age) = 30;
    }
    return 0;
}
static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };
