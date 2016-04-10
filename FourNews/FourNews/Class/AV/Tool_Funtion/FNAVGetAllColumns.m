//
//  FNAVGetAllColumns.m
//  FourNews
//
//  Created by admin on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVGetAllColumns.h"
#import "FNNetWorking.h"

@implementation FNAVGetAllColumns

+ (void)getAllColumns:(void (^)(NSArray *))complete
{
    [FNNetWorking GET:@"http://c.m.163.com/nc/video/topiclist.html" parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        complete(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
