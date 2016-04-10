//
//  FNGetNewsListDatas.h
//  FourNews
//
//  Created by xmg on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNGetNewsListDatas : NSObject

+ (void)getNewsListItemsWithProgramaid:(NSString *)pgmid :(NSInteger)count :(void(^)(NSArray *))complete;

@end
