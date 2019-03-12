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

//MyBlock test() {
//    int a = 10;
//    return ^{
//        NSLog(@"Hello a = %d", a);
//    };
//}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
          
      // 在ARC下block什么时候会对block进行copy?
//        int a = 20;
        // 当block赋值给一个强指针的时候。
//        int a = 20;
//        MyBlock block = ^{
//            NSLog(@"Hello a = %d", a);
//        };
//        NSLog(@"%@",[block class]);
        
        //block当做一个函数参数返回的时候
//        MyBlock block = test();
//        block();
//        NSLog(@"%@",[block class]);
//         GCD的block
        
    }
    return 0;
}

void test1() {
    MyBlock block;
    {
        MyPerson *person = [[MyPerson alloc] init];
        __weak typeof(person) weakPerson = person;
        block = ^{
            NSLog(@"person is a %@", weakPerson);
        };
        //            [person release];
    }
    
    block();
}
