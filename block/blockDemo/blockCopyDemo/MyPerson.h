//
//  MyPerson.h
//  blockCopyDemo
//
//  Created by CharType on 2019/3/10.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPerson : NSObject
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) void (^block)(void);
@end

NS_ASSUME_NONNULL_END
