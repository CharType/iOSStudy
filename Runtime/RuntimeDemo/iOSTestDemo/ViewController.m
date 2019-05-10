//
//  ViewController.m
//  iOSTestDemo
//
//  Created by CharType on 2019/5/9.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id cls = [Person class];
    void *obj = &cls;
    [(__bridge id)obj print];
    
}


@end
