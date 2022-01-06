#pragma clang assume_nonnull end

//int a = 10;  block中使用全局变量转换之后
//static int b = 20;
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        void (^block)(void) = ^{
//            NSLog(@"a = %d b = %d", a, b);
//        };
//        a = 100;
//        b = 200;
//        block();
//    }
//    return 0;
//}

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

//声明 全局变量
int a = 10;
static int b = 20;


struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int flags=0) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_e350e4_mi_0, a, b);
}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};
int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
        void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA));
        a = 100;
        b = 200;
        ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
    }
    return 0;
}
