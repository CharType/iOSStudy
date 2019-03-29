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

   dispatch_queue_global_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"这个线程：%@", [NSThread currentThread]);
        dispatch_queue_global_t queue1 = dispatch_get_global_queue(0, 0);
        dispatch_sync(queue1, ^{
            NSLog(@"GCD线程：%@", [NSThread currentThread]);
        });
    });
    
}


@end
