//
//  main.m
//  Block_循环引用
//
//  Created by CharType on 2019/3/13.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        {
            MyPerson *person = [[MyPerson alloc] init];
            person.age = 20;
            person.block = ^{
                NSLog(@"person.age = %ld",person.age);
            };
        }
        
        {
            __block MyPerson *person2 = [[MyPerson alloc] init];
            person2.age = 20;
            person2.block = ^{
                person2.age = 30;
                NSLog(@"person.age = %ld",person2.age);
            };            
        }
        
        // 解决循环引用， 在ARC下
        {
            // __weak
            MyPerson *person = [[MyPerson alloc] init];
            person.age = 20;
            __weak typeof (person) weakPerson = person;
            person.block = ^{
                NSLog(@"person.age =  %ld",weakPerson.age);
            };
        }
        
        {
            //__unsafe_unretained
            MyPerson *person = [[MyPerson alloc] init];
            person.age = 20;
            __unsafe_unretained typeof (person) weakPerson = person;
            person.block = ^{
                NSLog(@"person.age =  %ld",weakPerson.age);
            };
        }
        
        {
            //__block
            MyPerson *person = [[MyPerson alloc] init];
            person.age = 20;
            __block typeof (person) weakPerson = person;
            person.block = ^{
                NSLog(@"person.age =  %ld",weakPerson.age);
                weakPerson = nil;
            };
            // 必须要调用block
            person.block();
        }
        
        // 解决循环引用， 在MRC下
//        {
//            //__unsafe_unretained
//            MyPerson *person = [[MyPerson alloc] init];
//            person.age = 20;
//            __unsafe_unretained typeof(person) weakPerson = person;
//            person.block = ^{
//                NSLog(@"person.age =  %ld",weakPerson.age);
//            };
//            [person release];
//        }
//
//        {
//            //__block
//            MyPerson *person = [[MyPerson alloc] init];
//            person.age = 20;
//            __block typeof(person) weakPerson = person;
//            person.block = ^{
//                NSLog(@"person.age =  %ld",weakPerson.age);
//            };
//
//            [person release];
//        }
    }
    return 0;
}
