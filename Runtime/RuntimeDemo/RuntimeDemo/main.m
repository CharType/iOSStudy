//
//  main.m
//  RuntimeDemo
//
//  Created by CharType on 2019/5/6.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [[Person alloc] init];
        person.name = @"chengqian";
        [Person test];
        [person test];
        
    }
    return 0;
}
