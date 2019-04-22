//
//  ViewController.m
//  OsUnfairLockDemo
//
//  Created by CharType on 2019/4/22.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"
#import <os/lock.h>

@interface ViewController ()
@property (nonatomic, assign) NSInteger tickerCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tickerCount = 15;
    dispatch_queue_t queue =  dispatch_get_global_queue(0, 0);
    for (int i = 0; i < self.tickerCount; i++) {
        dispatch_async(queue, ^{
            [self ticketTest];
        });
    }
    
    for (int i = 0; i < self.tickerCount; i++) {
        dispatch_async(queue, ^{
            [self ticketTest];
        });
    }
    
    for (int i = 0; i < self.tickerCount; i++) {
        dispatch_async(queue, ^{
            [self ticketTest];
        });
    }
}

- (void)ticketTest {
    self.tickerCount--;
    NSLog(@"卖出一张票，还剩%ld张票",  self.tickerCount);
}


@end
