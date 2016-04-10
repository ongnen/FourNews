//
//  FNTopicGetListItem.m
//  FourNews
//
//  Created by xmg on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicGetListItem.h"
#import "FNTopicListItem.h"
#import <MJExtension.h>

@implementation FNTopicGetListItem

+ (void)getTopicNewsListWithPageCount:(NSInteger)pageCount :(void (^)(NSArray *))complete
{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/expert/%ld0-10.html",pageCount];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        NSArray *items = [FNTopicListItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"expertList"]];
        complete(items);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
