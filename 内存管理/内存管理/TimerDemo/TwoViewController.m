//
//  TwoViewController.m
//  TimerDemo
//
//  Created by CharType on 2019/5/22.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "TwoViewController.h"
#import "Myproxy.h"
#import "MyProxyTwo.h"

@interface TwoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *TextView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation TwoViewController

- (void)dealloc {
//    [self.timer invalidate];
    [self.displayLink invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSTime测试";
//    self.timer = [NSTimer timerWithTimeInterval:2 target:[Myproxy proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:[MyProxyTwo proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:[MyProxyTwo proxyWithTarget:self] selector:@selector(timerTest)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)timerTest {
    NSLog(@"%s", __func__);
}
@end
