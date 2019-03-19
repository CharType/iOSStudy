//
//  main.m
//  blockDemo
//
//  Created by CharType on 2019/3/1.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    // blok捕获的b变量
    int a;
    int *b
    NSObject *__strong object;
}

static struct __main_block_desc_0 {
    size_t reserved;// 保留参数
    size_t Block_size;
    void *copy;
    void *dispose;
}

void (^block)(void);
int a = 10;
static int b = 20;

void test1() {
    //        带有参数的block main_block2.cpp
//            void (^block)(int, int) = ^(int a, int b) {
//                NSLog(@"a = %d b = %d", a, b);
//            };
//            block(10,20);
    
    //        最简单的bblock   main_block1.cpp
//            void (^block)(void) = ^{
//                NSLog(@"Hello, World!");
//            };
//            block();
}

void test2() {
    
    //    block的变量捕获机制
    
    
    // 使用到局部变量和静态变量的block main_block3.cpp
//    int a = 10;
//    static int  b= 20;
//    void (^block)(void) = ^{
//        NSLog(@"a = %d b = %d", a, b);
//    };
//    a = 100;
//    b = 200;
//    block();
    
    //使用到全局变量的block main_block4.cpp
    //    void (^block)(void) = ^{
    //        NSLog(@"a = %d b = %d", a, b);
    //    };
    //    a = 100;
    //    b = 200;
    //    block();
    
    
}

void test3() {
    
    static int d;
    {
        int c = 10;
        block = ^{
            NSLog(@"c = %d d = %d", c, d);
        };
        d = 20;
        
    }
    
    d = 40;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        test1();
//        test2();
        test3();
        
        block();
    }
    return 0;
}


