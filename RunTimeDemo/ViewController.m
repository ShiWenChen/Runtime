//
//  ViewController.m
//  RunTimeDemo
//
//  Created by ShiWen on 2017/4/26.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"
#import <objc/objc-runtime.h>
#import "Student.h"
#import "NSObject+CSObject.h"
#import "Student+Property.h"
#import "DogFood.h"
#import "Dog.h"
@interface ViewController ()

@end

@implementation ViewController

+(void)load{
    NSLog(@"viewcontrollerload");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic = @{@"age":@"10",@"name":@"Tom",@"dogName":@"闪电",@"dogSunAge":@"1000",@"dog":@{@"dogName":@"闪电儿子",@"dogAge":@"1",@"dogFood":@{@"foodName":@"猫粮"}}};
    Student *stu = [[Student alloc]initWithDict:dic];
    stu.dogAge = 100;
    NSLog(@"%@",[NSString jsonWithDict:dic]);
    
    NSLog(@"stu:%i,%@,%@",stu.age,stu.name,stu.dog);
    NSLog(@"runtime动态添加属性%i",stu.dogAge);
    [NSKeyedArchiver archiveRootObject:stu toFile:[NSString stringWithFormat:@"%@/nsk",NSHomeDirectory()]];
    UIImage *image = [UIImage imageNamed:@"01.png"];
    NSLog(@"%@",image);
    
    Student *stu2 = [Student modelWithDicts:dic];
    NSLog(@"%@",stu2.dog.dogFood.foodName);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
