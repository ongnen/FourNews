//
//  FNMeGetSquareItem.m
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNMeGetSquareItem.h"
#import "FNMeSquareItem.h"
#import <MJExtension.h>

@implementation FNMeGetSquareItem

+ (NSURLSessionDataTask *)squareItem:(void (^)(NSArray *))complete
{
    // 查看接口文档 -> 发送请求 -> 解析数据
    // 1.创建请求会话管理者
    // 2.创建请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    return [FNNetWorking GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress *progress) {
        
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        NSArray *itemArray = [FNMeSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        complete(itemArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
