//
//  Student.h
//  RunTimeDemo
//
//  Created by ShiWen on 2017/4/26.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dog;
@interface Student : NSObject
{
//    int _dogSunAge;

}

/**
 *  年龄
 */
@property (atomic , assign)int  age;

/**
 *  名字
 */
@property (nonatomic , copy) NSString  *name;
/**
 *   狗
 */
@property (nonatomic , strong)Dog *dog;

@end
