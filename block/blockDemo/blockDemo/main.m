//
//  main.m
//  blockDemo
//
//  Created by CharType on 2019/3/1.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

void (^Myblock)(void);
int a = 10;
static int b = 20;

//void test1() {
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
//}

//void test2() {

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
    
    
//}

//void test3() {
//
//    static int d;
//    {
//        int c = 10;
//        block = ^{
//            NSLog(@"c = %d d = %d", c, d);
//        };
//        d = 20;
//
//    }
//
//    d = 40;
//}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        int a = 10;
//        int *a = 10;
        
//        test1();
//        test2();
//        test3();
//        block();
//        int c = 10;
//        NSObject *strongObject = [[NSObject alloc] init];
//        void (^testBlock)(void) =  ^{
//            NSLog(@"c = %d", c);
//            NSLog(@"strongObject = %@", strongObject);
//        };
//
//
//        __weak NSObject *weakObject = strongObject;
//
//        void (^block)(void) = ^{
//            NSLog(@"c = %d d strongObject =  %@ weakObject = %@", c, strongObject, weakObject);
//            NSLog(@"testBlock = %@",testBlock);
//        };
//
//        [block copy];
        {
            Student *s = [[Student alloc] init];
        }
        NSLog(@"hahahahah");
    }
    return 0;
}


