//
//  ViewController.m
//  ZTHThreadDemo
//
//  Created by CharType on 2019/3/27.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"
#import "ZTHViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *nextButton;
@end

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
    ZTHViewController *viewController = [[ZTHViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
