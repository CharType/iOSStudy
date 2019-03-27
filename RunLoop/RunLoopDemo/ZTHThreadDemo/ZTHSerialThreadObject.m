//
//  ZTHSerial ThreadObject.m
//  ZTHThreadDemo
//
//  Created by CharType on 2019/3/27.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ZTHSerialThreadObject.h"

@interface ZTHThread : NSThread
@end

@implementation ZTHThread
- (void) dealloc {
    NSLog(@"%s", __func__);
}
@end

@interface ZTHSerialThreadObject ()
@property (nonatomic, strong) ZTHThread *thread;
@property (nonatomic, assign) BOOL stopThread;
@end

@implementation ZTHSerialThreadObject

- (void) dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)init {
    if (self = [super init]) {
        self.stopThread = NO;
        __weak typeof(self) weakSelf = self;
        self.thread = [[ZTHThread alloc] initWithBlock:^{
            NSLog(@"tesk 开始");
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.stopThread) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
            NSLog(@"tesk 结束");
        }];
    }
    return self;
}

- (void)run {
    [self.thread start];
}

- (void)executeBlock:(void (^)(void))block {
    if (self.stopThread || !block) {
        return;
    }
    [self performSelector:@selector(executeTask:) onThread:self.thread withObject:block waitUntilDone:NO];
}

- (void)executeTask:(void (^)(void))block {
    block();
}

- (void)stop {
    self.stopThread = YES;
    [self performSelector:@selector(stopThreadAction) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)stopThreadAction {
    CFRunLoopStop(CFRunLoopGetCurrent());
}

@end
