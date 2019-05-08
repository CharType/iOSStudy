//
//  main.m
//  superDemo
//
//  Created by CharType on 2019/5/7.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Student *student = [[Student alloc] init];
        Person *person = [[Person alloc] init];
        
        NSLog(@"[student isKindOfClass:[Person class]] =  %ld", [student isKindOfClass:[Person class]]);
         NSLog(@"[student isMemberOfClass:[Person class]] =  %ld", [student isMemberOfClass:[Person class]]);
        
        NSLog(@"[person isKindOfClass:[Person class]] =  %ld", [person isKindOfClass:[Person class]]);
        NSLog(@"[person isMemberOfClass:[Person class]] =  %ld", [person isMemberOfClass:[Person class]]);
    }
    return 0;
}
