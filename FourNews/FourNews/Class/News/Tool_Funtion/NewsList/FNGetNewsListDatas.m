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
#import "NSObject+AddTimeid.h"
#import "FNStatusCacheTool.h"
#import "FNStatusParamModel.h"
#import <AFNetworking.h>

@implementation FNGetNewsListDatas

+ (void)getNewsListItemsWithProgramaid:(NSString *)pgmid :(NSInteger)count :(NSInteger)timeid :(void (^)(NSArray *nullable))complete
{
    NSInteger loc = [pgmid rangeOfString:@"/"].location+1;
    NSString *newPgmid = [NSString stringWithFormat:@"%@FNNewsListItem", [pgmid substringFromIndex:loc]];
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if (count == 1) {
        // 上拉刷新阅读记录为 未读
        [FNStatusCacheTool setOriginReadSkimWithName:newPgmid];
        // 如果有网络则刷新最新数据
        if (mgr.isReachable) {
            NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/%ld0-20.html",pgmid,count*2];
            
            [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
            } success:^(id responseObject, NSURLSessionDataTask *task) {
                // 转模型
                NSInteger loc = [pgmid rangeOfString:@"/"].location+1;
                NSArray *dicArray = responseObject[[pgmid substringFromIndex:loc]];
                NSMutableArray<FNNewsListItem *> *array = [FNNewsListItem mj_objectArrayWithKeyValuesArray:dicArray];
                
                // 给timeid赋值
                [FNNewsListItem setTimeidAttributeWithModelArray:array timeName:@"ptime"];
                
                // 全部模型添加广告字段
                for (int i = 0; i<array.count; i++) {
                    array[i].ads = array[0].ads;
                }
                
                // 加入缓存
                [FNStatusCacheTool addStatusCache:array :newPgmid];
                
                
                // 数组根据timeid排序
                NSArray *newArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    FNNewsListItem *item1 = obj1;
                    FNNewsListItem *item2 = obj2;
                    if (item1.timeid > item2.timeid) {
                        return NSOrderedAscending;
                    } else {
                        return NSOrderedDescending;
                    }
                }];
                // 请求成功后重置isReady
                [[NSNotificationCenter defaultCenter] postNotificationName:FNRefreshReady object:nil];
                
                complete(newArray);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
            
            return;
            // 没网络
        } else {
            // 取缓存
            FNStatusParamModel *param = [[FNStatusParamModel alloc] init];
            param.modelName = newPgmid;
            param.count = 20;
            param.timeid = 0;
            NSMutableArray *dicArray = [FNStatusCacheTool getStatusCache:param];
            if (dicArray.count) {// 没网络但有缓存数据就用缓存
                complete(dicArray);
                return;
            } else { // 没网络没缓存
                complete(nil);
                [[NSNotificationCenter defaultCenter] postNotificationName:FNNewsNetInvalid object:nil];
                return;
            }
        }
    }
    
    // 取缓存
    FNStatusParamModel *param = [[FNStatusParamModel alloc] init];
    param.modelName = newPgmid;
    param.count = 20;
    param.timeid = timeid;
    NSArray *dicArray = [FNStatusCacheTool getStatusCache:param];
    if (dicArray.count) {
        complete(dicArray);
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/%ld0-20.html",pgmid,count*2];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        // 转模型
        NSInteger loc = [pgmid rangeOfString:@"/"].location+1;
        NSArray *dicArray = responseObject[[pgmid substringFromIndex:loc]];
        NSMutableArray<FNNewsListItem *> *array = [FNNewsListItem mj_objectArrayWithKeyValuesArray:dicArray];
        
        // 给timeid赋值
        [FNNewsListItem setTimeidAttributeWithModelArray:array timeName:@"ptime"];
        
        // 全部模型添加广告字段
        for (int i = 0; i<array.count; i++) {
            array[i].ads = array[0].ads;
        }
        
        // 加入缓存
        [FNStatusCacheTool addStatusCache:array :newPgmid];
        
        // 数组根据timeid排序
        NSArray *newArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            FNNewsListItem *item1 = obj1;
            FNNewsListItem *item2 = obj2;
            if (item1.timeid > item2.timeid) {
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        }];
        complete(newArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end
