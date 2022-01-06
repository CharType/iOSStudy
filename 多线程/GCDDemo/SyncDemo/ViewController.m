//
//  ViewController.m
//  SyncDemo
//
//  Created by CharType on 2019/4/29.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) NSInteger ticketCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticketCount = 15;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            [self ticketTest];
        });
    }
    
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            [self ticketTest];
        });
    }
    
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            [self ticketTest];
        });
    }
}

- (void)ticketTest {
    @synchronized (self) {
        self.ticketCount--;
        sleep(60);
        NSLog(@"卖出一张票，还剩%ld张票",  self.ticketCount);
    }
}

@end
