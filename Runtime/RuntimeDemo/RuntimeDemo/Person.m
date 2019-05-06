//
//  MyPerson.m
//  RuntimeDemo
//
//  Created by CharType on 2019/5/6.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Sturent.h"

@implementation Person

- (void)otherInstanceTest {
    NSLog(@"%s", __func__);
}

+ (void)otherClassTest {
    NSLog(@"%s", __func__);
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if (sel == @selector(test)) {
//        Method method = class_getInstanceMethod(self, @selector(otherInstanceTest));
//        class_addMethod(self, sel, method_getImplementation(method), method_getTypeEncoding(method));
//        return YES;
//    }
//
//    return [super resolveInstanceMethod:sel];
//}
//
//+ (BOOL)resolveClassMethod:(SEL)sel {
//
//    if (sel == @selector(test)) {
//        Method method = class_getClassMethod(self, @selector(otherClassTest));
//
//        class_addMethod(object_getClass(self), sel, method_getImplementation(method), method_getTypeEncoding(method));
//        return YES;
//    }
//
//    return [super resolveClassMethod:sel];
//}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [[Sturent alloc] init];
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    return [[Sturent alloc] init];
}
@end
