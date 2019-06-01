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

@interface ViewController ()

@end

@implementation ViewController

void _objc_autoreleasePoolPrint(void);

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [Person personWithsex:@"adadsad"];
//    [NSString stringWithFormat:@"hahahahahhahahhahahahhahahah"];
//    NSObject *obj =  [Person personObject];
//    [Person createPersonWithName:@"jahah"];
//    NSString *personName =  [Person personName];
//    NSString *persontagPointName =  [Person persontagPointName];
    // 不是Autorelease对象
    NSArray *array = [NSArray array];
    
//    NSMutableArray *array = [NSMutableArray array];
//    [array addObject:@"adsbajdbjahsdjahbsdhas"];
//    [array addObject:@"adsbajasdalkdsladbjahsdjahbsdhas"];
//    NSLog(@"%zd",malloc_size(((__bridge const void *))array));
    
    // 输出Autoreleasepool中的所有对象
    _objc_autoreleasePoolPrint();
    NSLog(@"ssss");
    
}


@end
