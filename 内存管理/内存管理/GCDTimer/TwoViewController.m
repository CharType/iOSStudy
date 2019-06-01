//
//  TwoViewController.m
//  GCDTimer
//
//  Created by CharType on 2019/5/24.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"开始啦");
//    dispatch_queue_t queue = dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    uint64_t start = 2.0;
    uint64_t inter = 1.0;

    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), inter * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"开始执行任务 %@", [NSThread currentThread]);
    });
    dispatch_resume(timer);
    self.timer = timer;
}

@end
