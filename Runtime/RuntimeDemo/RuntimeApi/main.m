//
//  main.m
//  RuntimeApi
//
//  Created by CharType on 2019/5/19.
//  Copyright © 2019 CharType. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 动态创建一个类
        Class cls = objc_allocateClassPair([NSObject class], "Person", 1);
        BOOL success = class_addIvar(cls, "_age", 4, 1, @encode(int));
        NSLog(@"是否添加成功 %d", success);
        //注册一个类
        objc_registerClassPair(cls);
       
        // 销毁这个类
//        objc_disposeClassPair(cls);
        
        // 创建一个实例对象
        id obj = [[cls alloc] init];
        NSLog(@"%@", obj);
        // 获取对象的Class
        NSLog(@"是否是Class对象%d 是否是Class对象 %d", object_isClass(obj), object_isClass(object_getClass(obj)));
        NSLog(@"类对象%@ 是否是原类对象 %d", object_getClass(obj), class_isMetaClass(object_getClass(obj)));
        NSLog(@"原类对象%@ 是否是原类对象%d", object_getClass([obj class]), class_isMetaClass(object_getClass([obj class])));
        
        // 获取父类
        Class supercls = class_getSuperclass(cls);
        NSLog(@"获取到父类是%@", supercls);
        
        // 设置指向isa指针的class
        object_setClass(obj, [NSObject class]);
        NSLog(@"设置完之后的对象的类型 %@", obj);
        
        Student *stu = [[Student alloc] init];
        stu.name = @"chengqian";
        
        Ivar ivar = class_getInstanceVariable([Student class], "_name");
        NSLog(@"实例变量的名字是 %s", ivar_getName(ivar));
        NSLog(@"实例变量的类型是 %s", ivar_getTypeEncoding(ivar));
        NSLog(@"--------------------------------------------------------------");
        
        // 直接获取到成员变量的值
        NSLog(@"%@", object_getIvar(stu, ivar));
        
        // 设置成员变量
        object_setIvar(stu, ivar, @"lalalla");
        NSLog(@"设置之后的新值%@", object_getIvar(stu, ivar));
        
        // 动态的给类添加成员变量(只能给未注册的类添加成功)
        BOOL isAddSuccess = class_addIvar([Student class], "_age", 4, 1, @encode(int));
        NSLog(@"是否添加成功 %d", isAddSuccess);
        
        // 遍历成员变量
        unsigned int ivarsCount = 0;
        Ivar *ivars = class_copyIvarList([Student class], &ivarsCount);
        
        for (int i = 0; i <ivarsCount; i++) {
            Ivar ivar = ivars[i];
            NSLog(@"实例变量的名字是 %s, 实例变量的类型是 %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
        }
        free(ivars);
        NSLog(@"属性--------------------------------------------------------------");
        objc_property_t property = class_getProperty([Student class], "sex");
        NSLog(@"获取到的属性名：%s", property_getName(property));
        NSLog(@"获取到的属性一些信息：%s", property_getAttributes(property));
    
        objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([NSString class])] UTF8String] }; //type
        objc_property_attribute_t ownership0 = { "C", "" }; // C = copy
        objc_property_attribute_t ownership = { "N", "" }; //N = nonatomic
        objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", @"age"] UTF8String] };  //variable name
        objc_property_attribute_t attrs[] = { type, ownership0, ownership, backingivar };

        BOOL a = class_addProperty([Student class], "age", attrs, 4);
        NSLog(@"a = %d", a);
        NSLog(@"遍历属性列表--------------------------------------------------------------");
        unsigned int propertyListCount;
        objc_property_t *propertyList = class_copyPropertyList([Student class], &propertyListCount);
        for (int i = 0; i < propertyListCount; i++) {
            objc_property_t property = propertyList[i];
            NSLog(@"获取到的属性一些信息：%s", property_getAttributes(property));
        }
        
        free(propertyList);
        
    }
    return 0;
}
