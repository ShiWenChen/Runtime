//
//  CSKeyedArch.h
//  RunTimeDemo
//
//  Created by ShiWen on 2017/5/2.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#ifndef CSKeyedArchiver_h
#define CSKeyedArchiver_h
#import <objc/runtime.h>

/**
 initWithCoder

 @param className 需要实现initWithCoder的类名
 */
#define encodeRuntime(className) \
\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([className class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [self valueForKey:key];\
[aCoder encodeObject:value forKey:key];\
}\
free(ivars);\
\

/**
 initCoderRuntime

 @param className 需要实现initCoderRuntime的类名
 */
#define initCoderRuntime(className) \
\
if (self = [super init]) {\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([className class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [aDecoder decodeObjectForKey:key];\
[self setValue:value forKey:key];\
}\
free(ivars);\
}\
return self;\
\

#endif /* CSKeyedArchiver_h */
