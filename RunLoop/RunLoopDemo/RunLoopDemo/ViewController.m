//
//  ViewController.m
//  RunLoopDemo
//
//  Created by CharType on 2019/3/23.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
    NSLog(@"%p, %p", [NSRunLoop currentRunLoop], [NSRunLoop mainRunLoop]);
    NSLog(@"%p, %p", CFRunLoopGetCurrent(), CFRunLoopGetMain());
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, obseverRunLoopActicities, NULL);
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//        CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
//        switch (activity) {
//            case kCFRunLoopEntry:
//                NSLog(@"kCFRunLoopEntry即将进入Loop mode = %@", mode);
//                break;
//            case kCFRunLoopBeforeTimers:
//                NSLog(@"kCFRunLoopBeforeTimers即将处理Timer mode = %@", mode);
//                break;
//            case kCFRunLoopBeforeSources:
//                NSLog(@"kCFRunLoopBeforeSources即将处理Sources mode = %@", mode);
//                break;
//            case kCFRunLoopBeforeWaiting:
//                NSLog(@"kCFRunLoopBeforeWaiting即将进入休眠 mode = %@", mode);
//                break;
//            case kCFRunLoopAfterWaiting:
//                NSLog(@"kCFRunLoopAfterWaiting刚从休眠中唤醒 mode = %@", mode);
//                break;
//            case kCFRunLoopExit:
//                NSLog(@"kCFRunLoopExit即将退出loop mode = %@", mode);
//                break;
//
//            default:
//                break;
//        }
//
//    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"dispatch_after");
    });
    
    NSObject performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>
    
    CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, ^{
        NSLog(@"CFRunLoopPerformBlock");
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
}


@end
