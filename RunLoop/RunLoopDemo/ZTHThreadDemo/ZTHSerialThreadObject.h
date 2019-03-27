//
//  ZTHSerial ThreadObject.h
//  ZTHThreadDemo
//
//  Created by CharType on 2019/3/27.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZTHSerialThreadObject : NSObject

- (void)run;

- (void)executeBlock:(void (^)(void))block;

- (void)stop;

@end

