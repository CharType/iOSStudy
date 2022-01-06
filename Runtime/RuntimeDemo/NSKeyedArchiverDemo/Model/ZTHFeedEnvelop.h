//
//  ZTHFeedEnvelop.h
//  NSKeyedArchiverDemo
//
//  Created by CharType on 2019/5/8.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZTHTagEnvelop;
@interface ZTHFeedEnvelop : NSObject<NSCoding>
@property (nonatomic, strong) NSArray<ZTHTagEnvelop *> *tags;
@end

