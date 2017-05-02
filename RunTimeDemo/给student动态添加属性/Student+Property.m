//
//  Student+Property.m
//  RunTimeDemo
//
//  Created by ShiWen on 2017/4/28.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "Student+Property.h"
#import <objc/objc-runtime.h>

@implementation Student (Property)

-(void)setDogAge:(int)dogAge{
//    objc_setAssociatedObject 将某个值和对象关联起来，将某个值存储在对象中
//     object:给哪个对象添加属性
//     key:属性名称
//     value:属性值
//     policy:保存策略
//    self.dogAge = dogAge;
    objc_setAssociatedObject(self, "dogAge", [NSString stringWithFormat:@"%i",dogAge], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(int)dogAge{
    return [objc_getAssociatedObject(self, "dogAge") intValue];
}

@end
