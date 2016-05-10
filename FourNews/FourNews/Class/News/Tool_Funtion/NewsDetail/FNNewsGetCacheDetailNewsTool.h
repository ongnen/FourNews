//
//  FNNewsGetCacheDetailNewsTool.h
//  FourNews
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNNewsGetCacheDetailNewsTool : NSObject

/**
 * 缓存数据的方法
 */
+ (void)addStatusCache:(NSObject *)newsItem;

/**
 * 读取数据的方法
 */
+ (NSObject *)getStatusCache:(NSObject *)detailId;

@end
