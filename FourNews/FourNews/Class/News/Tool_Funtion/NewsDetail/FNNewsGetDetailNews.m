//
//  FNNewsGetDetailNews.m
//  FourNews
//
//  Created by admin on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsGetDetailNews.h"
#import "FNNewsDetailItem.h"
#import <MJExtension.h>

@implementation FNNewsGetDetailNews

+ (void)getNewsDetailWithDocid:(NSString *)docid :(void (^)(id))complete
{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",docid];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
//        NSLog(@"%@",responseObject);
        
        FNNewsDetailItem *item = [FNNewsDetailItem mj_objectWithKeyValues:responseObject[docid]];
        complete(item);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


@end
