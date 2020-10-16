//
//  Student.m
//  blockDemo
//
//  Created by CharType on 2020/8/11.
//  Copyright © 2020 CharType. All rights reserved.
//

#import "Student.h"
@interface Student()
@property (nonatomic, strong) void (^MyBlock)(void);
@end
@implementation Student

- (instancetype)init {
    if (self = [super init]) {
        [self test3];
    }
    return self;
}
- (void)dealloc {
    NSLog(@"%s",__func__);
}
- (void)test3 {
    __weak typeof(self) weakSelf = self;
    self.MyBlock = ^{
        __strong Student *self = weakSelf;
        [super test3];
    };
}
@end
