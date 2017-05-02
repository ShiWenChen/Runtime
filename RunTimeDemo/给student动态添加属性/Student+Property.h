//
//  Student+Property.h
//  RunTimeDemo
//
//  Created by ShiWen on 2017/4/28.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "Student.h"

@interface Student (Property)
//在分类中添加属性，系统不会自动实现get和set方法
@property (nonatomic,assign) int dogAge;

@end
