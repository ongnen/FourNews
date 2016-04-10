//
//  FNGetNewsListDatas.m
//  FourNews
//
//  Created by xmg on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNGetNewsListDatas.h"
#import "FNNewsListItem.h"
#import <MJExtension.h>

@implementation FNGetNewsListDatas

+ (void)getNewsListItemsWithProgramaid:(NSString *)pgmid :(NSInteger)count :(void (^)(NSArray *))complete
{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/%ld0-20.html",pgmid,count*2];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        NSInteger loc = [pgmid rangeOfString:@"/"].location+1;
        NSArray *dicArray = responseObject[[pgmid substringFromIndex:loc]];
        NSArray *array = [FNNewsListItem mj_objectArrayWithKeyValuesArray:dicArray];
        complete(array);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

@end
