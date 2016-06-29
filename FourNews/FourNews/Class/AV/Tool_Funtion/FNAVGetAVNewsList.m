//
//  FNAVGetAVNewsList.m
//  FourNews
//
//  Created by admin on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVGetAVNewsList.h"
#import <MJExtension.h>
#import "FNAVListItem.h"

@implementation FNAVGetAVNewsList

+ (void)getAVNewsListWithTid:(NSString *)tid :(NSInteger)pageCount :(void (^)(NSArray *))complete
{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/Tlist/%@/%ld0-10.html",tid,(long)pageCount];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        // 转模型
        NSArray *items = [FNAVListItem mj_objectArrayWithKeyValuesArray:responseObject[tid]];
        // 请求成功后重置isReady
        [[NSNotificationCenter defaultCenter] postNotificationName:FNRefreshReady object:nil];
        // 返回数据
        complete(items);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
