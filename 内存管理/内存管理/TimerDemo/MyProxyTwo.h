//
//  MyProxyTwo.h
//  TimerDemo
//
//  Created by CharType on 2019/5/23.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyProxyTwo : NSProxy
+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
