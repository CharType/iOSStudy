//
//  Myproxy.m
//  TimerDemo
//
//  Created by CharType on 2019/5/22.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "Myproxy.h"

@interface Myproxy()
@property (nonatomic, weak) id target;
@end

@implementation Myproxy
+ (instancetype)proxyWithTarget:(id)target {
    Myproxy *proxy = [[Myproxy alloc] init];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end
