//
//  FNNewsGetReply.m
//  FourNews
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsGetReply.h"
#import "FNNewsReplyItem.h"
#import <MJExtension.h>

@implementation FNNewsGetReply

+ (void)hotReplyWithDetailItem:(FNNewsDetailItem *)item :(void (^)(NSArray *))compelet
{
    NSString *urlStr = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",item.replyBoard,item.docid];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        //        NSLog(@"%@",responseObject);
        NSMutableArray *replyArray = [NSMutableArray array];
        
        // 数组中放模型数组,这样来存储评论数据
        [responseObject[@"hotPosts"] enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *itemArray = [NSMutableArray array];
            [obj1 enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj2, BOOL * _Nonnull stop) {
                if (![key isEqualToString:@"NON"]) {
                    [itemArray addObject:[FNNewsReplyItem mj_objectWithKeyValues:obj2]];
                }
            }];
            [replyArray addObject:itemArray];
        }];
        compelet(replyArray);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        NSArray *array;
        compelet(array);
    }];
}

+ (void)newReplyWithDetailItem:(FNNewsDetailItem *)item :(NSInteger)replyPage :(void (^)(NSArray *))compelet
{
    NSString *urlStr = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/normal/%@/%@/desc/0/%ld0/10/2/2",item.replyBoard,item.docid,replyPage+1];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        //        NSLog(@"%@",responseObject);
        NSMutableArray *replyArray = [NSMutableArray array];
        
        // 数组中放模型数组,这样来存储评论数据
        [responseObject[@"newPosts"] enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *itemArray = [NSMutableArray array];
            [obj1 enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj2, BOOL * _Nonnull stop) {
                if (![key isEqualToString:@"NON"]) {
                    [itemArray addObject:[FNNewsReplyItem mj_objectWithKeyValues:obj2]];
                }
            }];
            [replyArray addObject:itemArray];
            
        }];
        compelet(replyArray);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
