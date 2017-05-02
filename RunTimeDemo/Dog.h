//
//  Dog.h
//  RunTimeDemo
//
//  Created by ShiWen on 2017/4/28.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DogFood;

@interface Dog : NSObject
/**
 *  狗名
 */
@property (nonatomic , copy)NSString *dogName;
/**
 *  狗年龄
 */
@property (nonatomic , assign)int dogAge;
/**
 *  食物
 */
@property (nonatomic , strong)DogFood *dogFood;
@end
