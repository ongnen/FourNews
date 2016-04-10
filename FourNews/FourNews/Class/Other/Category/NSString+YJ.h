//
//  NSString+YJ.h
//  FourNews
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
// 给我一个时间字符串和时间格式字符串 返回一个常用的时间字符串

#import <Foundation/Foundation.h>

@interface NSString (YJ)

+ (nonnull NSString *)dateStringWithString:(nonnull NSString *)string :(nonnull NSString *)dateFormater;

@end
