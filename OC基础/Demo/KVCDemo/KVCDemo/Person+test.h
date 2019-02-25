//
//  Person+test.h
//  KVCDemo
//
//  Created by CharType on 2019/2/20.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "Person.h"


@interface Person (test)<NSCopying,NSCoding>
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) double height;
@property (nonatomic, copy) NSString *name;
- (void)test;
+ (void)test1;
@end
