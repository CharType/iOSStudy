//
//  main.m
//  blockCopyDemo
//
//  Created by CharType on 2019/3/6.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPerson.h"
typedef  void (^MyBlock)(void);
void blockTypeTest();

//MyBlock test() {
//    int a = 10;
//    return ^{
//        NSLog(@"Hello a = %d", a);
//    };
//}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
          
//        MyPerson *person = [[MyPerson alloc] init];
//        person.age = 20;
//        MyBlock block = ^{
//                    NSLog(@"person.age = %ld", person.age);
//                };
//
//        block();
        
        blockTypeTest();
    }
    return 0;
}

void blockTypeTest() {
    // NSStackBlock 不会对捕获的变量强引用
    MyBlock block;
    {
        MyPerson *person = [[MyPerson alloc] init];
        person.age = 20;
//        __weak typeof(person) weakPerson = person;
//        block = ^{
//            NSLog(@"person.age = %ld", person.age);
//        };

        // 在MRC下 block存储在栈区 不会对person对象强引用 只有block被copy的时候 才会对person对象强引用
        // 在ARC下 这个block会自动进行copy ,所以会对person对象强引用
//        __weak typeof(person) weakPerson = person;
        block = ^{
            NSLog(@"person.age = %ld", person.age);
        };
        
        [person release];
    }
    
    block();
    
//    [block release];
}
