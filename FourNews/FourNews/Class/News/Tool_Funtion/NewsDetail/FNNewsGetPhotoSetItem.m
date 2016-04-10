//
//  FNNewsGetPhotoSetItem.m
//  FourNews
//
//  Created by admin on 16/4/5.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsGetPhotoSetItem.h"
#import "FNNewsPhotoSetItem.h"
#import <MJExtension.h>


@implementation FNNewsGetPhotoSetItem

+ (void)getNewsDetailWithPhotoid:(NSString *)photoid :(void (^)(id))complete
{
    NSArray *param = [[photoid substringFromIndex:4] componentsSeparatedByString:@"|"];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",param.firstObject,param.lastObject];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        // 拿到一个图集描述模型数组
        NSMutableArray *photos = [FNNewsPhotoSetItem mj_objectArrayWithKeyValuesArray:responseObject[@"photos"]];
        // 为模型数组添加数据
        for (FNNewsPhotoSetItem *item in photos) {
            item.source = responseObject[@"source"];
            item.datatime = responseObject[@"datatime"];
            item.creator = responseObject[@"creator"];
            item.setname = responseObject[@"setname"];
        }
        complete(photos);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

@end
