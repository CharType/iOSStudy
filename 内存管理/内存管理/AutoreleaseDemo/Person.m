//
//  Person.m
//  AutoreleaseDemo
//
//  Created by CharType on 2019/5/29.
//  Copyright © 2019 CharType. All rights reserved.
//

#import "Person.h"

@interface Person ()

@end

@implementation Person
+(Person *)createPersonWithName:(NSString *)name {
    Person *person = [[Person alloc] init];
    person.name = name;
    return person;
}

+ (Person *)personWithsex:(NSString *)sex {
    Person *p = [[Person alloc] init];
    p.name = sex;
    return p;
}

+(NSString *)personName {
    return @"哈酒的撒基督教奥德赛卡就不对劲啊活动吧卡包带几哈读书笔记啊";
}

+(NSString *)persontagPointName {
    return @"abc";
}

+ (NSObject *)personObject {
    NSObject *obj = [[NSObject alloc] init];
    return obj;
}


@end
