//
//  ViewController.m
//  pthreadMutexDemo
//
//  Created by CharType on 2019/4/23.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()
@property (nonatomic, assign) NSInteger ticketCount;
// 互斥锁
@property (nonatomic, assign) pthread_mutex_t defaultLock;
// 递归锁
@property (nonatomic, assign) pthread_mutex_t recursiveLock;

// 条件
@property (nonatomic, assign) pthread_cond_t cond;
// 条件锁
@property (nonatomic, assign) pthread_mutex_t condLock;

@property (nonatomic, assign) dispatch_queue_t queue;


@end

@implementation ViewController

- (void)dealloc {
    pthread_mutex_destroy(&_defaultLock);
    pthread_mutex_destroy(&_recursiveLock);
}

- (void)initRecursiveMutexLock:(pthread_mutex_t *)lock {
    // 定义属性
    pthread_mutexattr_t attr;
    // 初始化属性
    pthread_mutexattr_init(&attr);
    // 递归锁 允许一个线程对同一把锁重复加锁
    // 设置属性的type
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    // 初始化锁
    pthread_mutex_init(lock, &attr);
    // 释放属性
    pthread_mutexattr_destroy(&attr);
}

- (void)initDefaultMutexLock:(pthread_mutex_t *)lock {
    // 定义属性
    pthread_mutexattr_t attr;
    // 初始化属性
    pthread_mutexattr_init(&attr);
    // 设置属性的type // 互斥锁
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    // 初始化锁
    pthread_mutex_init(lock, &attr);
    // 释放属性
    pthread_mutexattr_destroy(&attr);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDefaultMutexLock:&_defaultLock];
    [self initRecursiveMutexLock:&_recursiveLock];
    self.ticketCount = 15;
    self.queue = dispatch_get_global_queue(0, 0);
    [self ticketTest];
//    [self recursiveTest];
}

- (void)ticketTest {
    for (int i = 0; i < 5; i++) {
        dispatch_async(self.queue, ^{
            [self ticketRun];
        });
    }
    
    for (int i = 0; i < 5; i++) {
        dispatch_async(self.queue, ^{
            [self ticketRun];
        });
    }
    
    for (int i = 0; i < 5; i++) {
        dispatch_async(self.queue, ^{
            [self ticketRun];
        });
    }
}

- (void)ticketRun {
    pthread_mutex_lock(&_defaultLock);
    NSInteger oldTicketsCount = self.ticketCount;
    oldTicketsCount--;
    self.ticketCount = oldTicketsCount;
    NSLog(@"还剩%ld张票 - %@", oldTicketsCount, [NSThread currentThread]);
    pthread_mutex_unlock(&_defaultLock);
}


- (void)recursiveTest {
    [self recursiveRun];
}

- (void)recursiveRun {
    pthread_mutex_lock(&_recursiveLock);
    static int count = 0;
    NSLog(@"%s---%d",__func__, count);
    if (count < 10) {
        count++;
        [self recursiveRun];
    }
    pthread_mutex_unlock(&_recursiveLock);
}

@end
