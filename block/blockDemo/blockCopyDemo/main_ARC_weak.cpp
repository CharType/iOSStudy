

struct MyPerson_IMPL {
	struct NSObject_IMPL NSObject_IVARS;
};

// @property (nonatomic, assign) NSInteger age;
/* @end */

#pragma clang assume_nonnull end
typedef void (*MyBlock)(void);
void test1();


//MyPerson *person = [[MyPerson alloc] init];
//person.age = 20;
//__weak typeof(person) weakPerson = person;
//MyBlock block = ^{
//    NSLog(@"person.age = %ld", weakPerson.age);
//};
//
//block();

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  MyPerson *__weak weakPerson;// block捕获的person对象
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, MyPerson *__weak _weakPerson, int flags=0) : weakPerson(_weakPerson) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};

//block封装的函数
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
  MyPerson *__weak weakPerson = __cself->weakPerson; // bound by copy

                    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_f018a4_mi_0, ((NSInteger (*)(id, SEL))(void *)objc_msgSend)((id)weakPerson, sel_registerName("age")));
                }

// copy函数
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->weakPerson, (void*)src->weakPerson, 3/*BLOCK_FIELD_IS_OBJECT*/);}

// dispose函数
static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->weakPerson, 3/*BLOCK_FIELD_IS_OBJECT*/);}

// block描述结构体
static struct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
  void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
  void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = {
    0,
    sizeof(struct __main_block_impl_0),
    __main_block_copy_0,
    __main_block_dispose_0,
};

int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
        
        // MyPerson *person = [[MyPerson alloc] init];
        MyPerson *person = ((MyPerson *(*)(id, SEL))(void *)objc_msgSend)((id)((MyPerson *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("MyPerson"), sel_registerName("alloc")), sel_registerName("init"));
        
        // person.age = 20
        ((void (*)(id, SEL, NSInteger))(void *)objc_msgSend)((id)person, sel_registerName("setAge:"), (NSInteger)20);
        
        // __weak typeof(person) weakPerson = person;
        __attribute__((objc_ownership(weak))) typeof(person) weakPerson = person;
        
        // 定义block
        MyBlock block = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, weakPerson, 570425344));
        
        // 调用block
        ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);

    }
    return 0;
}


struct __test1_block_impl_0 {
  struct __block_impl impl;
  struct __test1_block_desc_0* Desc;
  MyPerson *__strong person;
  __test1_block_impl_0(void *fp, struct __test1_block_desc_0 *desc, MyPerson *__strong _person, int flags=0) : person(_person) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __test1_block_func_0(struct __test1_block_impl_0 *__cself) {
  MyPerson *__strong person = __cself->person; // bound by copy

            NSLog((NSString *)&__NSConstantStringImpl__var_folders_kl_mghcpydn7wl8ch2z9jz19pg00000gn_T_main_f018a4_mi_1, ((NSInteger (*)(id, SEL))(void *)objc_msgSend)((id)person, sel_registerName("age")));
        }
static void __test1_block_copy_0(struct __test1_block_impl_0*dst, struct __test1_block_impl_0*src) {_Block_object_assign((void*)&dst->person, (void*)src->person, 3/*BLOCK_FIELD_IS_OBJECT*/);}

static void __test1_block_dispose_0(struct __test1_block_impl_0*src) {_Block_object_dispose((void*)src->person, 3/*BLOCK_FIELD_IS_OBJECT*/);}

static struct __test1_block_desc_0 {
  size_t reserved;
  size_t Block_size;
  void (*copy)(struct __test1_block_impl_0*, struct __test1_block_impl_0*);
  void (*dispose)(struct __test1_block_impl_0*);
} __test1_block_desc_0_DATA = { 0, sizeof(struct __test1_block_impl_0), __test1_block_copy_0, __test1_block_dispose_0};
void test1() {

    MyBlock block;
    {
        MyPerson *person = ((MyPerson *(*)(id, SEL))(void *)objc_msgSend)((id)((MyPerson *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("MyPerson"), sel_registerName("alloc")), sel_registerName("init"));
        ((void (*)(id, SEL, NSInteger))(void *)objc_msgSend)((id)person, sel_registerName("setAge:"), (NSInteger)20);







        block = ((void (*)())&__test1_block_impl_0((void *)__test1_block_func_0, &__test1_block_desc_0_DATA, person, 570425344));


    }

    ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);


}
static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };
