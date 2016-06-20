//
//  NSString+YJ.m
//  FourNews
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//  给我一个时间字符串和时间格式字符串 返回一个常用的时间字符串

#import "NSString+YJ.h"

@implementation NSString (YJ)

+ (nonnull NSString *)dateStringWithString:(nonnull NSString *)string :(nonnull NSString *)dateFormater
{
    // 创建设置日期格式
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = dateFormater;
    // 设置时间为北京时区
    [format setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    // 调用NSDateFormatter的对象方法得到NSDate  @"yyyy-MM-dd HH:mm:ss"
    NSDate *newsDate = [format dateFromString:string];
    
    // 根据时间差输出不同的时间
    
    // 1.用日历(NSCalendar)输出“昨天”“**月**日”格式的时间
    // 2.用NSDate输出“**秒前”“**分前”“**小时前”的时间
    
    // 返回北京时区的当前时间
    // 拿到系统时间
    NSDate *nowDate = [NSDate date];
    // 拿到当前时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 拿到当前时区与系统时间的时间差
    NSTimeInterval interval = [zone secondsFromGMTForDate:nowDate];
    // 返回本地时间
    NSDate *localDate = [nowDate dateByAddingTimeInterval:interval];
    
    
    // 单独calendar不能输出，要配合NSDateCompoents输出时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentNow = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:localDate];
    
    NSDateComponents *componentNews = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:newsDate];
    
    if ((componentNow.day-componentNews.day)==1) {
        return [NSString stringWithFormat:@"昨天 %ld:%ld",(long)componentNews.hour,componentNews.minute];
    } else if ((componentNow.day-componentNews.day)==2) {
        return [NSString stringWithFormat:@"前天 %ld:%ld",(long)componentNews.hour,componentNews.minute];
    } else if ((componentNow.day-componentNews.day)>2 | (componentNow.month-componentNews.month)>0 | (componentNow.year-componentNews.year)>0) {
        if ((componentNow.year-componentNews.year)>0) {
            return [NSString stringWithFormat:@"%ld.%ld.%ld %ld:%ld",(long)componentNews.year,componentNews.month,componentNews.day,componentNews.hour,componentNews.minute];
        }
        return [NSString stringWithFormat:@"%ld.%ld %ld:%ld",(long)componentNews.month,componentNews.day,componentNews.hour,componentNews.minute];
        
    } else {
        NSTimeInterval timeInterval = [localDate timeIntervalSinceDate:newsDate];
        if (timeInterval < 60) {
            return [NSString stringWithFormat:@"%ld秒前",(long)timeInterval];
        } else if (timeInterval < 60*60) {
            return [NSString stringWithFormat:@"%ld分前",(NSInteger)timeInterval/60];
        } else {
            return [NSString stringWithFormat:@"%ld小时前",(NSInteger)timeInterval/3600];
        }
    }
}


@end
