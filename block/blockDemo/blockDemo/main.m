//
//  main.m
//  blockDemo
//
//  Created by CharType on 2019/3/1.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface Persion : NSObject
//@property (nonatomic, copy) NSString *name;
//@end
//
//@implementation Persion
//
//@end

//int a = 10;
//static int b = 20;
void test1() {
    
    //    block的变量捕获机制
    
    //        使用到全局变量的block main_block4.cpp
    //        void (^block)(void) = ^{
    //            NSLog(@"a = %d b = %d", a, b);
    //        };
    //        a = 100;
    //        b = 200;
    //        block();
    
    //        使用到局部变量和静态变量的block main_block3.cpp
    //        int a = 10;
    //        static int b = 20;
    //        void (^block)(void) = ^{
    //            NSLog(@"a = %d b = %d", a, b);
    //        };
    //        a = 100;
    //        b = 200;
    //        block();
    
    
    //        带有参数的block main_block2.cpp
    //        void (^block)(int, int) = ^(int a, int b) {
    //            NSLog(@"a = %d b = %d", a, b);
    //        };
    //
    //        block(10,20);
    
    //        最简单的bblock   main_block1.cpp
    //        void (^block)(void) = ^{
    //            NSLog(@"Hello, World!");
    //        };
    //        block();
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        test1();
        

    }
    return 0;
}

