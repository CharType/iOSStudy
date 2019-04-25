//
//  ViewController.m
//  NSLockDemo
//
//  Created by CharType on 2019/4/26.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) NSInteger ticketCount;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSRecursiveLock *recursiveLock;
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, strong) NSConditionLock *conditionLock;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mutableArray = [NSMutableArray array];
    self.lock = [[NSLock alloc] init];
    self.recursiveLock = [[NSRecursiveLock alloc] init];
    self.condition = [[NSCondition alloc] init];
    self.conditionLock = [[NSConditionLock alloc] initWithCondition:1];
    self.ticketCount = 15;
    
//    [[[NSThread alloc] initWithTarget:self selector:@selector(deleteObject) object:nil] start];
//    [[[NSThread alloc] initWithTarget:self selector:@selector(addObject) object:nil] start];
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(deleteObjectConditionLock) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(addObjectConditionLock) object:nil] start];
    
    
//    [self lockTest];
}

- (void)addObject {
    [self.condition lock];
    sleep(1);
    [self.mutableArray addObject:@"测试"];
    NSLog(@"添加了元素");
    [self.condition signal];
    [self.condition unlock];
    
}

- (void)deleteObjectConditionLock {
    [self.conditionLock lockWhenCondition:2];
    [self.mutableArray removeLastObject];
    NSLog(@"删除了元素");
    [self.conditionLock unlockWithCondition:1];
}

- (void)addObjectConditionLock {
    [self.conditionLock lockWhenCondition:1];
    [self.mutableArray addObject:@"测试"];
    NSLog(@"添加了元素");
    [self.conditionLock unlockWithCondition:2];
    
}

- (void)deleteObject {
    [self.condition lock];
    if (self.mutableArray.count == 0) {
        [self.condition wait];
    }
    [self.mutableArray removeLastObject];
    NSLog(@"删除了元素");
    [self.condition unlock];
}

- (void)lockTest {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            [self ticketTest];
        });
    }
    
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            [self ticketTest];
        });
    }
    
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            [self ticketTest];
        });
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self recursiveRun];
}

- (void)ticketTest {
        [self.lock lock];
        self.ticketCount--;
        NSLog(@"卖出一张票，还剩%ld张票",  self.ticketCount);
        [self.lock unlock];
}

- (void)recursiveRun {
    [self.recursiveLock lock];
    static int count = 0;
    NSLog(@"%s---%d",__func__, count);
    if (count < 10) {
        count++;
        [self recursiveRun];
    }
    [self.recursiveLock unlock];
}

@end
