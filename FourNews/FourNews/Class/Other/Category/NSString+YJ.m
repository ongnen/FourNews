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
        return [NSString stringWithFormat:@"昨天 %ld:%ld",componentNews.hour,componentNews.minute];
    } else if ((componentNow.day-componentNews.day)==2) {
        return [NSString stringWithFormat:@"前天 %ld:%ld",componentNews.hour,componentNews.minute];
    } else if ((componentNow.day-componentNews.day)>2 | (componentNow.month-componentNews.month)>0 | (componentNow.year-componentNews.year)>0) {
        if ((componentNow.year-componentNews.year)>0) {
            return [NSString stringWithFormat:@"%ld.%ld.%ld %ld:%ld",componentNews.year,componentNews.month,componentNews.day,componentNews.hour,componentNews.minute];
        }
        return [NSString stringWithFormat:@"%ld.%ld %ld:%ld",componentNews.month,componentNews.day,componentNews.hour,componentNews.minute];
        
    } else {
        NSTimeInterval timeInterval = [localDate timeIntervalSinceDate:newsDate];
        if (timeInterval < 60) {
            return [NSString stringWithFormat:@"%ld秒前",(NSInteger)timeInterval];
        } else if (timeInterval < 60*60) {
            return [NSString stringWithFormat:@"%ld分前",(NSInteger)timeInterval/60];
        } else {
            return [NSString stringWithFormat:@"%ld小时前",(NSInteger)timeInterval/3600];
        }
    }
}
//NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
//NSLog(@"array_%@",timeZoneNames);
//NSString *startTime = @"2015-07-11 12:30";
//NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//[formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
////转化为东八区的时间，即背景时间NSLog(@"北京时间 %@",[formatter stringFromDate:[NSDate date]]);
//
//可以通过timeZoneNames数组查询各个时区的名字，都是以各大洲划分的。
//
//某一时区时间转化为手机本地系统时间
//
//- (void)day{    NSString *startTime = @"2015-07-11 12:30";    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];    NSDate *startDate = [dateformatter dateFromString:startTime];    NSDate *startTime = [self getNowDateFromatAnDate:startDate];    NSString *startDateStr = [dateformatter stringFromDate:startTime];    NSLog(@"%@",startDateStr);//这是最终转好的时间}- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate{    //设置源日期时区    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//或GMT    //设置转换后的目标日期时区    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];    //得到源日期与世界标准时间的偏移量    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];    //目标日期与本地时区的偏移量    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];    //得到时间偏移量的差值    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;    //转为现在时间    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];    return destinationDateNow;}

@end
