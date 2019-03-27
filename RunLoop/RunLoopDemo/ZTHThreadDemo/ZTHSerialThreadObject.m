//
//  ZTHSerial ThreadObject.m
//  ZTHThreadDemo
//
//  Created by CharType on 2019/3/27.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ZTHSerialThreadObject.h"

@interface ZTHSerialThreadObject ()
@property (nonatomic, strong) NSThread *thread;
@end

@implementation ZTHSerialThreadObject

- (void) dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)init {
    if (self = [super init]) {
        self.thread = [[NSThread alloc] initWithBlock:^{
            NSLog(@"tesk 开始");
            // CFRunLoopSourceContext 这个结构体最好赋值一个初始值
            CFRunLoopSourceContext context = {0};
            // 创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            // 添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            CFRelease(source);
            // 1.0e10 当前线程在默认模式(CFRunLoopDefaultMode)运行RunLoop,直到运行循环所有数据源和计时器是从默认的运行循环模式移动或者调用CFRunLoopStop函数停止RunLoop。
            // 第三个参数： 运行循环可以递归运行,可以从任何运行循环标注内调用CFRunLoopRun，并且当前线程调用栈上创建嵌套运行循环激活
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
            NSLog(@"tesk 结束");
        }];
    }
    return self;
}

- (void)run {
    [self.thread start];
}

- (void)executeBlock:(void (^)(void))block {
    if (!block) {
        return;
    }
    [self performSelector:@selector(executeTask:) onThread:self.thread withObject:block waitUntilDone:NO];
}

- (void)executeTask:(void (^)(void))block {
    block();
}

- (void)stop {
    [self performSelector:@selector(stopThreadAction) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)stopThreadAction {
    CFRunLoopStop(CFRunLoopGetCurrent());
}

@end
