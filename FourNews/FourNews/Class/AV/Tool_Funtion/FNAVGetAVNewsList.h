//
//  FNAVGetAVNewsList.h
//  FourNews
//
//  Created by admin on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNAVGetAVNewsList : NSObject

+ (void)getAVNewsListWithTid:(NSString *)tid :(NSInteger)pageCount :(void(^)(NSArray *))complete;

@end
