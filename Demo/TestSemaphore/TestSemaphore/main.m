//
//  main.m
//  TestSemaphore
//
//  Created by 程倩的MacBook on 2021/12/13.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0); // 1, 2
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"a: %@", [NSThread currentThread]);
        dispatch_semaphore_signal(sem);
    });

    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"b: %@", [NSThread currentThread]);
        dispatch_semaphore_signal(sem);
    });
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"c: %@", [NSThread currentThread]);
    });
    NSLog(@"exit");
    return 0;
}
