//
//  ViewController.m
//  TimerDemo
//
//  Created by CharType on 2019/5/22.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)btnClick:(id)sender {
    TwoViewController *viewController = [[TwoViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}



@end
