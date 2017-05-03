//
//  UIImage+EXchangeFun.m
//  RunTimeDemo
//
//  Created by ShiWen on 2017/4/28.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "UIImage+EXchangeFun.h"
#import <objc/objc-runtime.h>

@implementation UIImage (EXchangeFun)

/**
 把类加载进内存的时候调用并且只会调用一次
 */
+(void)load{
//    获取要交换的方法的地址
//    class_getClassMethod (获取某个类的方法)  @selector(imageName:) == sel_registerName("imageName:")
    Method imageNameMethod = class_getClassMethod(self, sel_registerName("imageNamed:"));
    
    //获取新方法
    Method lnImageNameMethod = class_getClassMethod(self, @selector(myImageNamed:));
    
    //交换方法地址，相当于交换实现方式
    method_exchangeImplementations(lnImageNameMethod, imageNameMethod);
    
    [super load];

    
}

/**
 新方法

 @param name 此时调用imageName:方法即为调用myImageNamed:,调用myImageNamed:方法即为调用系统的imageName:方法
 @return 图片
 */
+ (UIImage *)myImageNamed:(NSString *)name{
    UIImage *image = [UIImage myImageNamed:name];
    if (image) {
        NSLog(@"runtime获取成功");
        return image;
    }
    NSLog(@"runtime获取失败");
    return image;
}
@end
