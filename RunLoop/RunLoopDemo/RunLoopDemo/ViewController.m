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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%p, %p", [NSRunLoop currentRunLoop], [NSRunLoop mainRunLoop]);
    NSLog(@"%p, %p", CFRunLoopGetCurrent(), CFRunLoopGetMain());
}


@end
