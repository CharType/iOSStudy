//
//  ViewController.m
//  多线程Demo
//
//  Created by CharType on 2019/4/22.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"
#import <libkern/OSAtomic.h>

@interface ViewController ()
@property (nonatomic, assign) NSInteger ticketCount;
@property (nonatomic, assign) OSSpinLock lock;
@property (nonatomic, strong) NSLock *nslock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lock = OS_SPINLOCK_INIT;
    self.nslock = [[NSLock alloc] init];
    self.ticketCount = 15;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            [self ticketTest3];
        });
    }
    
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            [self ticketTest3];
        });
    }
    
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            [self ticketTest3];
        });
    }
}

- (void)ticketTest {
    OSSpinLockLock(&_lock);
    self.ticketCount--;
    NSLog(@"卖出一张票，还剩%ld张票",  self.ticketCount);
    OSSpinLockUnlock(&_lock);
}

- (void)ticketTest2 {
    // OSSpinLockTry 最好不要使用，会只执行一次任务
    if (OSSpinLockTry(&_lock)) {
        self.ticketCount--;
        NSLog(@"卖出一张票，还剩%ld张票",  self.ticketCount);
        OSSpinLockUnlock(&_lock);
    }
}

- (void)ticketTest3 {
//    [self.nslock lock];
//    self.ticketCount--;
//    NSLog(@"卖出一张票，还剩%ld张票",  self.ticketCount);
//    [self.nslock unlock];
    
    if ([self.nslock tryLock]) {
        // tryLock 最好不要使用，会只执行一次任务
        self.ticketCount--;
        NSLog(@"卖出一张票，还剩%ld张票",  self.ticketCount);
        [self.nslock unlock];
    }
}
@end
