//
//  Person.m
//  superDemo
//
//  Created by CharType on 2019/5/7.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)init {
    if (self = [super init]) {
//        NSLog(@"[self class] = %@", [self class]);
//        NSLog(@"[super class] = %@", [super class]);
//        
//        NSLog(@"[self superclass] = %@", [self superclass]);
//        NSLog(@"[super superclass] = %@", [super superclass]);
    }
    return self;
}

- (void)print {
    NSLog(@"hahahhahah -- - -%@", self.name);
}
@end
