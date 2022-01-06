//
//  main.m
//  superDemo
//
//  Created by CharType on 2019/5/7.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import <objc/runtime.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Student *student = [[Student alloc] init];
        Person *person = [[Person alloc] init];
        
        
        
        NSLog(@"[student isKindOfClass:[Person class]] =  %hhd", [student isKindOfClass:[Person class]]);
        NSLog(@"[student isMemberOfClass:[Person class]] =  %hhd", [student isMemberOfClass:[Person class]]);
        
        NSLog(@"[person isKindOfClass:[Person class]] =  %hhd", [person isKindOfClass:[Person class]]);
        NSLog(@"[person isMemberOfClass:[Person class]] =  %hhd", [person isMemberOfClass:[Person class]]);
        
        NSLog(@"[student isKindOfClass:[NSObject class]] =  %hhd", [student isKindOfClass:[NSObject class]]);
        Class cls =  object_getClass([Student class]);
        NSLog(@"[Student isMemberOfClass:[Student class]] = %hhd", [Student isKindOfClass:cls]);
    }
    return 0;
}
