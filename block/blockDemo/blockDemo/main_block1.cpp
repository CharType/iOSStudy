#pragma clang assume_nonnull end

//        最简单的bblock
//        void (^block)(void) = ^{
//            NSLog(@"Hello, World!");
//        };
//        block();

struct __block_impl {
    void *isa;// block的类型
    int Flags;  // 保存了引用计数的地址
    int Reserved;// 保留字段 0 未使用
    void *FuncPtr;// 函数地址
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    //构造函数，返回一个 __main_block_impl_0 结构体
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int flags=0) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};

// 被block封装的函数
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_ce330f_mi_0);
}
// 描述
static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __main_block_desc_0_DATA = {
    0,// 保留字段
    sizeof(struct __main_block_impl_0) // block的大小存储空间
};
int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
        
        /**
         删除类型转换之前：
         void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA));
         */
        // 定义block
        void (*block)(void) = &__main_block_impl_0(__main_block_func_0, &__main_block_desc_0_DATA));
        
        /**
         删除类型转换之前：
         ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
         */
        // 调用block
        block->FuncPtr(block);
    }
    return 0;
}
