//
//  Persion.m
//  blockDemo
//
//  Created by CharType on 2019/3/5.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "Persion.h"

@interface Persion()
@property (nonatomic, assign) int age;
@end

@implementation Persion

- (void)test3 {
    NSLog(@"%s",__func__);
}

- (void)test1 {
    // 每一个方法都有两个参数，一个是self,一个是 当前方法SEL _cmd 看clang转换之后的c++源码可以看到
    __weak Persion *p = self;

    void (^test1Block)(void) = ^{
        __strong Persion *p2 = p;
        NSLog(@"self = %@", p2);
    };
    
    
}

//- (void)test2 {
//    void (^test2Block)(void) = ^{
//        NSLog(@"age = %d", _age);
//    };
////   _age  相当于  self->_age
//}
@end
