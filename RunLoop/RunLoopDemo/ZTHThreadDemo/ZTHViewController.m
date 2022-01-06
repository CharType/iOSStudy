//
//  ZTHViewController.m
//  ZTHThreadDemo
//
//  Created by CharType on 2019/3/27.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ZTHViewController.h"
#import "ZTHSerialThreadObject.h"

@interface ZTHViewController ()
@property (nonatomic, strong) ZTHSerialThreadObject *threadObject;
@end

@implementation ZTHViewController

- (void) dealloc {
    [self.threadObject stop];
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.threadObject = [[ZTHSerialThreadObject alloc] init];
    [self.threadObject run];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.threadObject executeBlock:^{
        NSLog(@"执行任务 线程 = %@", [NSThread currentThread]);
    }];
}


@end
