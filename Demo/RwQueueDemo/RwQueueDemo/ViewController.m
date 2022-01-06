//
//  ViewController.m
//  RwQueueDemo
//
//  Created by 程倩的MacBook on 2021/12/13.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *dataString;
@property (nonatomic, strong) dispatch_queue_t rwqueue;
@end

@implementation ViewController
@synthesize dataString = _dataString
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)testRwLock {
    for(int i = 0;i < 300;i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataString = [NSString stringWithFormat:@"这个是在设置字符串：%d",i];
            NSLog(@"打印---%@",_dataString);
        });
    }
    
    for(int i = 0;i < 300;i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"打印---读取%@",self.dataString);
        });
    }
    
    for(int i = 0;i < 300;i++) {
        
    }
}

- (void)setDataString:(NSString *)dataString {
    dispatch_barrier_async(self.rwqueue, ^{
        _dataString = dataString;
    });
}

- (NSString *)dataString {
    __block NSString *str;
    dispatch_sync(self.rwqueue, ^{
        str = _dataString;
    });
    return str;
}


@end
