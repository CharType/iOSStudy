//
//  ViewController.m
//  otherDemo
//
//  Created by CharType on 2019/5/8.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_queue_t queue = dispatch_queue_create("hahahha", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"1");
//        [self performSelector:@selector(test) withObject:self afterDelay:1];
       
        NSLog(@"2");
    });
}

- (void)test {
    NSLog(@"3");
}


@end
