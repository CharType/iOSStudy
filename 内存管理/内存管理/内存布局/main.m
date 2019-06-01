//
//  main.m
//  内存布局
//
//  Created by CharType on 2019/5/24.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
int a = 10;
int b;
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        static int c = 20;
        
        static int d;
        
        
        int f = 20;
        int e;
        
        NSString *str = @"123";
        
        NSObject *obj = [[NSObject alloc] init];
        
        NSLog(@"\n&a=%p\n&b=%p\n&c=%p\n&d=%p\n&e=%p\n&f=%p\nstr=%p\nobj=%p\n",
              &a, &b, &c, &d, &e, &f, str, obj);
    }
    return 0;
}
