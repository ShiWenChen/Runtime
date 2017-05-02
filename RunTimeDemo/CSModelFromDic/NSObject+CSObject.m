//
//  NSObject+CSObject.m
//  RunTimeDemo
//
//  Created by ShiWen on 2017/4/26.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "NSObject+CSObject.h"

@implementation NSObject (CSObject)


/**
 类似JSONModel MJExtension
 通过字典给model赋值
 @param dict 字典
 */
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [self init]) {
        ///获取类的属性名称及属性对应的类型
        NSMutableArray *keys = [[NSMutableArray alloc]init];
        unsigned int outCount;
        
        /**
         获取类里面的所有属性

         @ class] 将要获取的类
         @ outCount 数量指针，最后值为属性个数
         @ return 属性数组，存储objc_property_t类型的数组
         */
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i< outCount; i++) {
            objc_property_t property = properties[i];
            //通过property_getName函数获得属性名字
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keys addObject:propertyName];
            NSLog(@"%@",propertyName);
        }
//        释放properties对应的内存
        free(properties);
        ///根据类型给属性赋值
        for (NSString *key in keys) {
            if ([dict valueForKey:key] == nil) continue;
            ///KVC的方式赋值
            [self setValue:[dict valueForKey:key] forKey:key];
        }
        
    }
    
    return self;
}
-(NSArray *)getProperty{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (unsigned int i = 0; i<outCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"%s,%s",name,type);
    }
    return array;
}
// Runtime:根据模型中属性,去字典中取出对应的value给模型属性赋值
// 思路：遍历模型中所有属性->使用运行时
+(instancetype)modelWithDict:(NSDictionary *)dic{
//    创建对应对象
    id objc = [[self alloc] init];
//    利用runtime给对象中的属性赋值
    /*
     class_copyIvarList 获取类中所有成员变量
     ivar：成员变量
     
     
     
     */
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivarList[i];
//        获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        除掉成员变量中的_其他标识符
        NSString *key = [ivarName substringFromIndex:1];
        id value = dic[key];
        NSLog(@"key:%@",key);
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
    
}

/**
 字典模型转换

 @param dic 嵌套型字典
 */
+(instancetype)modelWithDicts:(NSDictionary *)dic{
    id objct = [[self alloc] init];
    
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSString *key = [ivarName substringFromIndex:1];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        NSLog(@"%@",key);
        id value = [dic objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]] &&![ivarType hasPrefix:@"NS"]) {
            // 根据字符串类名生成类对象
            Class modelClass = NSClassFromString(ivarType);
            if (modelClass) {
                value = [modelClass modelWithDicts:value];

            }
        }
        if (value) {
            [objct setValue:value forKey:key];
        }
    }
    return objct;
}

+(NSString *)jsonWithDict:(NSDictionary *)dic{
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    return jsonStr;
}





@end
