//
//  FNTopicGetDetailItem.m
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicGetDetailItem.h"
#import "FNTopicDetailItem.h"
#import "FNTopicQuesItem.h"
#import "FNTopicAnswerItem.h"
#import <MJExtension.h>

@implementation FNTopicGetDetailItem

+ (void)getTopicNewsDetailWithExpertId:(NSString *)expertId :(BOOL)isNewQues :(NSInteger)pageCount :(void (^)(NSMutableArray *))complete
{
    if (isNewQues) {
        [self getTopicNewsLateDetailWithExpertId:expertId :pageCount :complete];
    } else {
        [self getTopicNewsHotDetailWithExpertId:expertId :pageCount :complete];
    }
}

+ (void)getTopicNewsHotDetailWithExpertId:(NSString *)expertId :(NSInteger)pageCount :(void (^)(NSMutableArray *))complete
{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/latestqa/%@/%ld0-10.html",expertId,pageCount];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        NSMutableArray *quesAnsArray = [NSMutableArray array];
        for (NSDictionary *quesAnsDic in responseObject[@"data"]) {
            FNTopicDetailItem *item = [[FNTopicDetailItem alloc] init];
            item.question = [FNTopicQuesItem mj_objectWithKeyValues:quesAnsDic[@"question"]];
            item.answer = [FNTopicAnswerItem mj_objectWithKeyValues:quesAnsDic[@"answer"]];
            [quesAnsArray addObject:item];
        }
        complete(quesAnsArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

+ (void)getTopicNewsLateDetailWithExpertId:(NSString *)expertId :(NSInteger)pageCount :(void (^)(NSMutableArray *))complete
{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/latestqa/%@/%ld0-10.html",expertId,pageCount+1];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        NSMutableArray *quesAnsArray = [NSMutableArray array];
        for (NSDictionary *quesAnsDic in responseObject[@"data"]) {
            FNTopicDetailItem *item = [[FNTopicDetailItem alloc] init];
            item.question = [FNTopicQuesItem mj_objectWithKeyValues:quesAnsDic[@"question"]];
            item.answer = [FNTopicAnswerItem mj_objectWithKeyValues:quesAnsDic[@"answer"]];
            [quesAnsArray addObject:item];
        }
        complete(quesAnsArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
