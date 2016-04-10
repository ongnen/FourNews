//
//  FNNewsGetSearchNews.m
//  FourNews
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsGetSearchNews.h"
#import "FNNewsSearchWordItem.h"
#import <MJExtension.h>

@implementation FNNewsGetSearchNews

+ (void)getSearchNewsWithWord:(NSString *)word :(void(^)(NSArray *))complete;
{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/search/comp/MA==/20/%@.html",word];
    NSString *newStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [FNNetWorking GET:newStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        
        NSArray *array = [FNNewsSearchWordItem mj_objectArrayWithKeyValuesArray:responseObject[@"doc"][@"result"]];
        complete(array);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
