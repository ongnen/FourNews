//
//  FNNewsGetDetailNews.m
//  FourNews
//
//  Created by admin on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsGetDetailNews.h"
#import "FNNewsDetailItem.h"
#import "FNNewsGetCacheDetailNewsTool.h"
#import <MJExtension.h>

@implementation FNNewsGetDetailNews

+ (void)getNewsDetailWithDocid:(NSString *)docid :(void (^)(id))complete
{
    // 检查缓存，有的话拿到返回
    FNNewsDetailItem *item = (FNNewsDetailItem *)[FNNewsGetCacheDetailNewsTool getStatusCache:docid];
    if (item) {
        complete(item);
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",docid];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        
        FNNewsDetailItem *item = [FNNewsDetailItem mj_objectWithKeyValues:responseObject[docid]];
        complete(item);
        // 加入缓存
        [FNNewsGetCacheDetailNewsTool addStatusCache:item];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


@end
