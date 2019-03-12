//
//  main.m
//  BlockTypeDemo
//
//  Created by CharType on 2019/3/6.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>

int c = 100;
static int d = 200;
void test1(void);
void test2(void);
void test3(void);
void (^block)(void);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        test1();
//        test2();
//        block();
        
//        test3();
        
        
    }
    return 0;
}

void test1(){
    // 没有访问局部变量的block类型
    void (^block1)(void) = ^{
        NSLog(@"hello");
    };
    NSLog(@"-----没有访问局部变量的block类型--------");
    NSLog(@"%@", [block1 class]); //  __NSGlobalBlock
    NSLog(@"%@", [[block1 class] superclass]); // __NSGlobalBlock
    NSLog(@"%@", [[[block1 class] superclass] superclass]); //NSBlock
    NSLog(@"%@", [[[[block1 class] superclass] superclass] superclass]); // NSObject
    
    // 访问局部变量的block类型
    int a = 10;
    void (^block2)(void) = ^{
        NSLog(@"hello a = %d", a);
    };
    NSLog(@"-----访问局部变量的block类型--------");
    NSLog(@"%@", [block2 class]);
    NSLog(@"%@", [[block2 class] superclass]);
    NSLog(@"%@", [[[block2 class] superclass] superclass]);
    NSLog(@"%@", [[[[block2 class] superclass] superclass] superclass]);
    
    // 访问静态变量的block类型
    static int b = 10;
    void (^block3)(void) = ^{
        NSLog(@"hello b = %d", b);
    };
    NSLog(@"-----访问静态变量的block类型--------");
    NSLog(@"%@", [block3 class]);
    NSLog(@"%@", [[block3 class] superclass]);
    NSLog(@"%@", [[[block3 class] superclass] superclass]);
    NSLog(@"%@", [[[[block3 class] superclass] superclass] superclass]);
    
    void (^block4)(void) = ^{
        NSLog(@"hello c = %d, d = %d", c, d);
    };
    NSLog(@"-----访问全局变量的block类型--------");
    NSLog(@"%@", [block4 class]);
    NSLog(@"%@", [[block4 class] superclass]);
    NSLog(@"%@", [[[block4 class] superclass] superclass]);
    NSLog(@"%@", [[[[block4 class] superclass] superclass] superclass]);
}

void test2() {
    // 在main函数中执行了这个方法,然后在执行block，在block中会执行什么
    // 在ARC下和MRC下有什么不同
    int a = 10;
//    block = ^{
//        NSLog(@"%d", a);
//    };
    
    block = [^{
        NSLog(@"%d", a);
    } copy];
    
    NSLog(@"block的class = %@", [block class]);
    // ARC下会对block做一次copy 
};

void test3() {
    void (^block1)(void) = ^{
        NSLog(@"hello");
    };
    
    int a = 10;
    void (^block2)(void) = ^{
        NSLog(@"hello a = %d", a);
    };
    
    NSLog(@"%@ -- %@ ", [block1 class], [[block2 copy] class]);
    
    NSLog(@"%@ -- %@", [block1 class], [block2 class]);
    
    // __NSStackBlock__ 调用了copy之后 类型变成 __NSMallocBlock__ 类型
}
