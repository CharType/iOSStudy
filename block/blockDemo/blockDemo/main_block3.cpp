
#pragma clang assume_nonnull end

//    auto变量和static变量的block转换之后
//    int a = 10;
//    static int b = 20;
//    void (^block)(void) = ^{
//        NSLog(@"a = %d b = %d", a, b);
//    };
//    a = 100;
//    b = 200;
//    block(); // a = 10 b = 200

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  int a;// auto类型局部变量
  int *b;// static类型的局部变量
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _a, int *_b, int flags=0) : a(_a), b(_b) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
  int a = __cself->a; // bound by copy
  int *b = __cself->b; // bound by copy

            NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_262dfb_mi_0, a, (*b));
        }

static struct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};
int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool; 
        int a = 10;
        static int b = 20;
        void (*block)(void) = &__main_block_impl_0(__main_block_func_0, &__main_block_desc_0_DATA, a, &b);
        // 简化之前
//        void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, a, &b));
        a = 100;
        b = 200;
        (block->FuncPtr)(block);
        // 简化之前
//        ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
    }
    return 0;
}
static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };
