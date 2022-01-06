//
//  Student.m
//  KVCDemo
//
//  Created by CharType on 2019/2/20.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "Student.h"

@implementation Student
//- (NSInteger)getAge {
//    NSLog(@"%s",__FUNCTION__);
//    return 10;
//}

//- (NSInteger)age {
//    NSLog(@"%s",__FUNCTION__);
//    return 20;
//}

//- (NSInteger)isAge {
//    NSLog(@"%s",__FUNCTION__);
//    return 30;
//}

//- (NSInteger)_age {
//    NSLog(@"%s",__FUNCTION__);
//    return 40;
//}

+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"%s",__FUNCTION__);
    return @(1000);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%s",__FUNCTION__);
}
@end
