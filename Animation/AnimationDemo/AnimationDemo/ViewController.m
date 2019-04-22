//
//  ViewController.m
//  AnimationDemo
//
//  Created by CharType on 2019/4/22.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    self.redView.backgroundColor = [UIColor redColor];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self rotationAngle];
}

- (void)rotationAngle {
    [UIView animateWithDuration:1 animations:^{
        self.redView.transform = CGAffineTransformMakeRotation(M_PI_4);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            self.redView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }];
    });
}

- (void)scaleTest {
    [UIView animateWithDuration:1 animations:^{
        self.redView.transform = CGAffineTransformMakeScale(3, 5);
        self.redView.backgroundColor = [UIColor blueColor];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            self.redView.transform = CGAffineTransformMakeScale(1, 1);
            self.redView.backgroundColor = [UIColor redColor];
        }];
    });
}
@end
