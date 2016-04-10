//
//  NSDictionary+Log.m
//  08-掌握-多值参数和中文输出
//
//  Copyright © 2020年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    //该方法用来控制字典的输出
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{\n"];
    
    //拼接字典中的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [string appendFormat:@"\t%@:",key];
        [string appendFormat:@"%@,\n",obj];
    }];
    
    [string appendString:@"}"];
    
    //删除最后的逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    
    return string;
}
@end

@implementation NSArray (Log)

-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    //该方法用来控制字典的输出
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"[\n"];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"%@,",obj];
    }];
    
    [string appendString:@"]"];
    
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    
    return string;
}
@end
