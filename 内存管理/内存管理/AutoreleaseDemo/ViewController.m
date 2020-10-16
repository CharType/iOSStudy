//
//  ViewController.m
//  AutoreleaseDemo
//
//  Created by CharType on 2019/5/29.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "TwoViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

void _objc_autoreleasePoolPrint(void);

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.button setTitle:@"下一页" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    self.button.backgroundColor = [UIColor redColor];
    [self.button addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    

    
}

- (void)test1 {
    TwoViewController *twoViewController = [[TwoViewController alloc] init];
//    twoViewController.navController = self.navigationController;
//    twoViewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:twoViewController animated:NO];
}

- (void)test {
    //    [Person personWithsex:@"adadsad"];
    //    [NSString stringWithFormat:@"hahahahahhahahhahahahhahahah"];
    //    NSObject *obj =  [Person personObject];
    //    [Person createPersonWithName:@"jahah"];
    //    NSString *personName =  [Person personName];
    //    NSString *persontagPointName =  [Person persontagPointName];
    // 不是Autorelease对象
//    NSArray *array = [NSArray array];
    
    //    NSMutableArray *array = [NSMutableArray array];
    //    [array addObject:@"adsbajdbjahsdjahbsdhas"];
    //    [array addObject:@"adsbajasdalkdsladbjahsdjahbsdhas"];
    //    NSLog(@"%zd",malloc_size(((__bridge const void *))array));
    
    // 输出Autoreleasepool中的所有对象
    _objc_autoreleasePoolPrint();
    NSLog(@"ssss");
}

@end
