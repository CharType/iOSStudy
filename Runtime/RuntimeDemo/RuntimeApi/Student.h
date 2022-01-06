//
//  Student.h
//  RuntimeApi
//
//  Created by CharType on 2019/5/19.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, assign) int studentId;
@property (nonatomic, assign) NSTimeInterval timeIntervar;
@property (nonatomic, strong) NSDate *date;
@end

NS_ASSUME_NONNULL_END
