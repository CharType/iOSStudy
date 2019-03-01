//
//  main.m
//  blockDemo
//
//  Created by CharType on 2019/3/1.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Persion : NSObject
@property (nonatomic, copy) NSString *name;
@end

@implementation Persion

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int a = 10;
        NSString *str = @"aaaaaaa";
        Persion *p = [[Persion alloc] init];
        p.name = @"chengqian";
        void (^block)(void) = ^{
            NSLog(@"a = %d str = %@", a, str);
            NSLog(@"name = %@",p.name);
        };
        a = 20;
        str = @"sssssss";
        p.name = @"zhangjiangdong";
        block();
        
        
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
    return 0;
}
