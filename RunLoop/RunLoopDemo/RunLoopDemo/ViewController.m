//
//  ViewController.m
//  RunLoopDemo
//
//  Created by CharType on 2019/3/23.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"
#import "TWOViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *nextButton;
@end

void obseverRunLoopActicities(CFRunLoopObserverRef ref,CFRunLoopActivity activity, void *info) {
    CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry即将进入Loop mode = %@", mode);
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers即将处理Timer mode = %@", mode);
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources即将处理Sources mode = %@", mode);
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting即将进入休眠 mode = %@", mode);
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting刚从休眠中唤醒 mode = %@", mode);
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit即将退出loop mode = %@", mode);
            break;
            
        default:
            break;
    }
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 80, 30)];
    [self.nextButton setTitle:@"下一页" forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextwindow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
}

- (void)nextwindow {
    TWOViewController *viewController = [[TWOViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)test1 {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
}

- (void)task {
    NSLog(@"task");
}

@end
