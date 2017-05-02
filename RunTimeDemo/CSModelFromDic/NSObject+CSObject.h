//
//  NSObject+CSObject.h
//  RunTimeDemo
//
//  Created by ShiWen on 2017/4/26.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/objc-runtime.h>

@interface NSObject (CSObject)

/**
 字典模型转换
 @param dict 需要转换的字典
 */
-(instancetype)initWithDict:(NSDictionary *)dict;

/**
 字典模型转换

 @param dic 将要转换的字典
 @return 返回当前模型
 */
+(instancetype)modelWithDict:(NSDictionary *)dic;

/**
 字典模型转换
 
 @param dic 嵌套型字典
 */
+(instancetype)modelWithDicts:(NSDictionary *)dic;
//-(instancetype)addProperty;

/**
 字典转json

 @param dic 将要转换字典
 @return json字符串
 */
+(NSString *)jsonWithDict:(NSDictionary*)dic;

@end
