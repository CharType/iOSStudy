//
//  MyPerson.m
//  blockCopyDemo
//
//  Created by CharType on 2019/3/10.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "MyPerson.h"

@implementation MyPerson
- (void)dealloc {
//    [super dealloc];
    NSLog(@"%s", __func__);
}
- (void)test {
    [super class];
}

- (void)print {
    NSLog(@"MyPerson -- print");
}

@end
