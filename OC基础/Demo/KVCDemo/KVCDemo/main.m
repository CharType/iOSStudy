//
//  main.m
//  KVCDemo
//
//  Created by CharType on 2019/2/20.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    
//        NSDictionary *dict = @{@"age":@(20)};
//        NSNumber *age = [dict valueForKey:@"ages"];
//        NSLog(@"%@",age);
//
//        IMP dictvalueForKey =  class_getMethodImplementation([dict class], @selector(valueForKey:));
//        IMP nsobjectvalueForKey =  class_getMethodImplementation([NSObject class], @selector(valueForKey:));
//        NSLog(@" dict %p object %p ", dictvalueForKey, nsobjectvalueForKey);
//        Person *p = [[Person alloc] init];
//        p.age = 10;
//       NSLog(@" person %@",[p valueForKey:@"age"]);
//        NSObject *obj = [[NSObject alloc] init];
//        Class isa = [obj valueForKey:@"isa"];
//        NSLog(@"%p", isa);
    
        Person *p2 = [[Person alloc] init];
        
        [p2 setValue:@(20) forKey:@"age"];
//        NSLog(@"%ld",p2->_age);
    
        Student *stu = [[Student alloc] init];
//        stu->_age = 10;
//        stu->_isAge = 20;
//        stu->isAge = 30;
//        stu->age = 40;
    
        NSLog(@"%@", [stu valueForKey:@"age"]);
    
        return 0;
}


