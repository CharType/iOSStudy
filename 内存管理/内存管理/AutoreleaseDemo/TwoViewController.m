//
//  TwoViewController.m
//  AutoreleaseDemo
//
//  Created by CharType on 2019/6/2.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "TwoViewController.h"
#import "ThereViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二个控制器";
    ThereViewController *viwController = [[ThereViewController alloc] init];
    viwController.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:viwController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
