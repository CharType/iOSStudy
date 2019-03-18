//
//  main.m
//  Block__blockDemo
//
//  Created by CharType on 2019/3/12.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPerson.h"

typedef  void (^MyBlock)(void);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        __block int age = 10;
//        MyBlock block = ^{
//            age = 20;
//            NSLog(@"%d",age);
//        };
//        // 这里直接访问age是访问的哪个age值？
//        NSLog(@"%p",blockImpl->age); //  0x10062f0e0
//        NSLog(@"%p",&age);// 0x10062f0f8
        
        
//        __block int age = 10;
//        __block  NSObject *object = [[NSObject alloc] init];
//        MyBlock block = ^{
//            age = 20;
//            NSLog(@"%d",age);
//            NSLog(@"%@",object);
//        };
        
//        __block MyPerson *person = [[MyPerson alloc] init];
//        __block __weak typeof(person) weakPerson = person;
        
        MyBlock block;
        {
           __block MyPerson *person = [[MyPerson alloc] init];
//            __block __weak typeof(person) weakPerson = person;
            
            block = ^{
                NSLog(@"%@",person);
            };
            [person release];
        }
        
        
        block();
        
    }
    return 0;
}
