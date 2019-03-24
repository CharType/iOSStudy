
#pragma clang assume_nonnull end

//int c = 10;
//NSObject *strongObject = [[NSObject alloc] init];
//void (^testBlock)(void) =  ^{
//    NSLog(@"c = %d", c);
//    NSLog(@"strongObject = %@", strongObject);
//};
//
//
//__weak NSObject *weakObject = strongObject;
//
//void (^block)(void) = ^{
//    NSLog(@"c = %d d strongObject =  %@ weakObject = %@", c, strongObject, weakObject);
//    NSLog(@"testBlock = %@",testBlock);
//};
//
//[block copy];

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    int c;
    NSObject *__strong strongObject;
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _c, NSObject *__strong _strongObject, int flags=0) : c(_c), strongObject(_strongObject) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    int c = __cself->c; // bound by copy
    NSObject *__strong strongObject = __cself->strongObject; // bound by copy
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_a59a2e_mi_0, c);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_a59a2e_mi_1, strongObject);
}
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->strongObject, (void*)src->strongObject, 3/*BLOCK_FIELD_IS_OBJECT*/);}

static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->strongObject, 3/*BLOCK_FIELD_IS_OBJECT*/);}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
    void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};

struct __main_block_impl_1 {
    struct __block_impl impl;
    struct __main_block_desc_1* Desc;
    int c;
    NSObject *__strong strongObject;
    NSObject *__weak weakObject;
    struct __block_impl *testBlock;
    __main_block_impl_1(void *fp, struct __main_block_desc_1 *desc, int _c, NSObject *__strong _strongObject, NSObject *__weak _weakObject, void *_testBlock, int flags=0) : c(_c), strongObject(_strongObject), weakObject(_weakObject), testBlock((struct __block_impl *)_testBlock) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};
static void __main_block_func_1(struct __main_block_impl_1 *__cself) {
    int c = __cself->c; // bound by copy
    NSObject *__strong strongObject = __cself->strongObject; // bound by copy
    NSObject *__weak weakObject = __cself->weakObject; // bound by copy
    void (*testBlock__strong)() = (void (*__strong)())__cself->testBlock; // bound by copy
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_a59a2e_mi_2, c, strongObject, weakObject);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_a59a2e_mi_3,testBlock);
}
static void __main_block_copy_1(struct __main_block_impl_1*dst, struct __main_block_impl_1*src) {_Block_object_assign((void*)&dst->strongObject, (void*)src->strongObject, 3/*BLOCK_FIELD_IS_OBJECT*/);_Block_object_assign((void*)&dst->weakObject, (void*)src->weakObject, 3/*BLOCK_FIELD_IS_OBJECT*/);_Block_object_assign((void*)&dst->testBlock, (void*)src->testBlock, 7/*BLOCK_FIELD_IS_BLOCK*/);}

static void __main_block_dispose_1(struct __main_block_impl_1*src) {_Block_object_dispose((void*)src->strongObject, 3/*BLOCK_FIELD_IS_OBJECT*/);_Block_object_dispose((void*)src->weakObject, 3/*BLOCK_FIELD_IS_OBJECT*/);_Block_object_dispose((void*)src->testBlock, 7/*BLOCK_FIELD_IS_BLOCK*/);}

static struct __main_block_desc_1 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __main_block_impl_1*, struct __main_block_impl_1*);
    void (*dispose)(struct __main_block_impl_1*);
} __main_block_desc_1_DATA = { 0, sizeof(struct __main_block_impl_1), __main_block_copy_1, __main_block_dispose_1};
int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
        int c = 10;
        
        //        NSObject *strongObject = [[NSObject alloc] init];
        NSObject *strongObject = ((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("alloc")), sel_registerName("init"));
        
        //void (^testBlock)(void) =  ^{
        //    NSLog(@"c = %d", c);
        //    NSLog(@"strongObject = %@", strongObject);
        //};
        void (*testBlock)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, c, strongObject, 570425344));
        
        //__weak NSObject *weakObject = strongObject;
        __attribute__((objc_ownership(weak))) NSObject *weakObject = strongObject;
        
        //void (^block)(void) = ^{
        //    NSLog(@"c = %d d strongObject =  %@ weakObject = %@", c, strongObject, weakObject);
        //    NSLog(@"testBlock = %@",testBlock);
        //};
        void (*block)(void) = ((void (*)())&__main_block_impl_1((void *)__main_block_func_1, &__main_block_desc_1_DATA, c, strongObject, weakObject, (void *)testBlock, 570425344));
        
        //[block copy];
        ((id (*)(id, SEL))(void *)objc_msgSend)((id)block, sel_registerName("copy"));
    }
    return 0;
}
