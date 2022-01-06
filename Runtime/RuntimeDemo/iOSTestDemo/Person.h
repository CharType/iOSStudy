//
//  Person.h
//  iOSTestDemo
//
//  Created by CharType on 2019/5/9.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
- (void)print;
@end

NS_ASSUME_NONNULL_END
