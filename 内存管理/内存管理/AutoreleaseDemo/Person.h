//
//  Person.h
//  AutoreleaseDemo
//
//  Created by CharType on 2019/5/29.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
+ (Person *)createPersonWithName:(NSString *)name;
+ (Person *)personWithsex:(NSString *)sex;
+(NSString *)personName;
+(NSString *)persontagPointName;

+ (NSObject *)personObject;
@end

