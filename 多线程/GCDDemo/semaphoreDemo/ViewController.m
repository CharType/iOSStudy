//
//  ViewController.m
//  semaphoreDemo
//
//  Created by CharType on 2019/4/28.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.semaphore = dispatch_semaphore_create(1);
    for (int i = 0; i < 10; i++) {
        [[[NSThread alloc] initWithTarget:self selector:@selector(semaphoreTest) object:nil] start];
    }
}

- (void)semaphoreTest {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    sleep(5);
    NSLog(@"%s - %@", __func__, [NSThread currentThread]);
    dispatch_semaphore_signal(self.semaphore);
}

@end
