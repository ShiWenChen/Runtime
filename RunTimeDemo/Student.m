//
//  Student.m
//  RunTimeDemo
//
//  Created by ShiWen on 2017/4/26.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "Student.h"
#import "CSKeyedArchiver.h"
@interface Student()<NSCoding>
//@property (nonatomic,copy) NSString *dogName;
@end

@implementation Student

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    initCoderRuntime(Student);
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    encodeRuntime(Student);
    
}
@end
