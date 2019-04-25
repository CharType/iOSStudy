//
//  ViewController.m
//  pthreadMutexCondition
//
//  Created by CharType on 2019/4/24.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()
// 条件
@property (nonatomic, assign) pthread_cond_t cond;
// 条件锁
@property (nonatomic, assign) pthread_mutex_t condLock;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@end

@implementation ViewController

- (void)dealloc {
    pthread_mutex_destroy(&_condLock);
    pthread_cond_destroy(&_cond);
}

- (void)initCondMutexLock:(pthread_mutex_t *)lock {
    // 定义属性
    pthread_mutexattr_t attr;
    // 初始化属性
    pthread_mutexattr_init(&attr);
    // 递归锁 允许一个线程对同一把锁重复加锁
    // 设置属性的type
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    // 初始化锁
    pthread_mutex_init(lock, &attr);
    // 初始化条件
    pthread_cond_init(&_cond, NULL);
    // 释放属性
    pthread_mutexattr_destroy(&attr);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mutableArray = [NSMutableArray array];
    
    [self initCondMutexLock:&_condLock];
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(deleteObject) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(addObject) object:nil] start];
}

- (void)addObject {
    pthread_mutex_lock(&_condLock);
    sleep(1);
    [self.mutableArray addObject:@"测试"];
    NSLog(@"添加了元素");
    pthread_cond_signal(&_cond);
    pthread_mutex_unlock(&_condLock);
    
}

- (void)deleteObject {
    pthread_mutex_lock(&_condLock);
    if (self.mutableArray.count == 0) {
        pthread_cond_wait(&_cond, &_condLock);
    }
    [self.mutableArray removeLastObject];
    NSLog(@"删除了元素");
    pthread_mutex_unlock(&_condLock);
}

@end
