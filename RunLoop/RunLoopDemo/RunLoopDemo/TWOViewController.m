//
//  TWOViewController.m
//  RunLoopDemo
//
//  Created by CharType on 2019/3/27.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "TWOViewController.h"
#import "ZTHThread.h"

@interface TWOViewController ()
@property (nonatomic, strong) ZTHThread *thread;
@property (nonatomic, assign) BOOL stopThread;
@end

@implementation TWOViewController

- (void)dealloc {
    [self performSelector:@selector(stopThreadAction) onThread:self.thread withObject:nil waitUntilDone:YES];
    NSLog(@"%s", __func__);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.stopThread = NO;
    __weak typeof(self) weakSelf = self;
    self.thread = [[ZTHThread alloc] initWithBlock:^{
        NSLog(@"task1 begin");
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//            NSLog(@"runloop的状态发生了改变");
//
//        });
//        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
//        CFRelease(observer);
        while (weakSelf && !weakSelf.stopThread) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        NSLog(@"task1 end");
    }];
    [self.thread start];
}

- (void)stopThreadAction {
    self.stopThread = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)test {
   
    NSLog(@"%s thread = %@", __func__, [NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.stopThread) {
        return;
    }
    [self performSelector:@selector(test) onThread:self.thread withObject:self waitUntilDone:NO];
}

@end
