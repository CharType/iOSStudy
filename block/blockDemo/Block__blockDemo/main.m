//
//  main.m
//  Block__blockDemo
//
//  Created by CharType on 2019/3/12.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  void (^MyBlock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        __block int age = 10;
        
        MyBlock block1 = ^{
            age = 20;
            NSLog(@"%d",age);
        };
        
        block1();
    }
    return 0;
}
