//
//  ViewController.m
//  GCDDemo
//
//  Created by CharType on 2019/3/29.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("chenhgqian", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务1 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务2 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_queue_t serialQueuee = dispatch_get_main_queue();
    dispatch_group_notify(group, serialQueuee, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务3 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, serialQueuee, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务4 %@", [NSThread currentThread]);
        }
    });
    
    
   

    
}

- (void)test2 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("chenhgqian", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务1 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务2 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_queue_t serialQueuee = dispatch_queue_create("chengqian111", DISPATCH_QUEUE_SERIAL);
    dispatch_group_notify(group, serialQueuee, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务3 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, serialQueuee, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务4 %@", [NSThread currentThread]);
        }
    });
}

- (void)test1 {
    // 并发队列
    dispatch_queue_global_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"异步执行 - 并发队列：%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"同步执行 - 并发队列：%@", [NSThread currentThread]);
    });
    
    //串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("chengqian", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"异步执行 - 串行队列:%@", [NSThread currentThread]);
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"同步执行 - 串行队列:%@", [NSThread currentThread]);
        // 如果同步往当前线程添加任务，会死锁
    });
    
    // 主队列
    dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"异步执行 - 主队列:%@", [NSThread currentThread]);
    });
    
    // 同步执行 - 主队列  会死锁
    //    dispatch_sync(mainQueue, ^{
    //        NSLog(@"同步执行 - 主队列:%@", [NSThread currentThread]);
    //    });
}

@end
