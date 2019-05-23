//
//  MyProxyTwo.m
//  TimerDemo
//
//  Created by CharType on 2019/5/23.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "MyProxyTwo.h"

@interface MyProxyTwo()
@property (nonatomic, weak) id target;
@end

@implementation MyProxyTwo
+ (instancetype)proxyWithTarget:(id)target {
    MyProxyTwo *proxy = [MyProxyTwo alloc];
    proxy.target = target;
    return proxy;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}
@end
