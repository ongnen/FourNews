//
//  MyUserDefaults.h
//  网易彩票2016
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNUserDefaults : NSObject

+ (id)objectWithKey:(NSString *)key;

+ (NSInteger)integerForKey:(NSString *)key;
+ (float)floatForKey:(NSString *)key;
+ (double)doubleForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;


+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;
+ (void)setFloat:(float)value forKey:(NSString *)key;
+ (void)setDouble:(double)value forKey:(NSString *)key;
+ (void)setBool:(BOOL)value forKey:(NSString *)key;

+ (void)setObject:(NSObject *)object forKey:(NSString *)key;

@end
