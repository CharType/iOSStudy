//
//  ViewController.m
//  serialQueueDemo
//
//  Created by CharType on 2019/4/26.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) NSInteger ticketCount;
@property (nonatomic, strong) dispatch_queue_t queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticketCount = 15;
    self.queue = dispatch_queue_create("chenegqian", DISPATCH_QUEUE_SERIAL);
    [self lockTest];
}

- (void)lockTest {
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
    dispatch_sync(self.queue, ^{
        self.ticketCount--;
        NSLog(@"卖出一张票，还剩%ld张票",  self.ticketCount);
    });
}

@end
