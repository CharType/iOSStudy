//
//  Person.m
//  KVCDemo
//
//  Created by CharType on 2019/2/20.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "Person.h"

@implementation Person
//- (void)setAge:(NSInteger)age {
//    NSLog(@"setAge");
//}
//
//- (void)_setAge:(NSInteger)age {
//    NSLog(@"_setAge");
//}
//+ (BOOL)accessInstanceVariablesDirectly {
//    return NO;
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"setValue:forUndefinedKey:");
}

- (void)test {
    NSLog(@"Person %s", __FUNCTION__);
}
@end
