//
//  FNNewsGetCacheDetailNewsTool.m
//  FourNews
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsGetCacheDetailNewsTool.h"
#import "FNNewsDetailItem.h"
#import "FNNewsPhotoSetItem.h"
#import <FMDB.h>

@implementation FNNewsGetCacheDetailNewsTool

static FMDatabaseQueue *_queue;

+ (void)setup
{
    // 1.在沙盒中创建数据库文件
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    // 2.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:file];
    
    // 3.创表
    [_queue inDatabase:^(FMDatabase *db) { // 这句代码内部包含了创建数据库实例
        [db executeUpdate:[NSString stringWithFormat:@"create table if not exists t_FNNewsDetail (detailId text primary key, dic blob);"]];
    }];
}

/**
 * 缓存数据的方法
 */
+ (void)addStatusCache:(NSObject *)newsItem
{
    [self setup];
    NSString *detailId;
    
    if ([newsItem isKindOfClass:[FNNewsDetailItem class]]) {
        detailId = [newsItem valueForKey:@"docid"];
    } else {
        NSArray *items = (NSArray *)newsItem;
        detailId = [items[0] valueForKey:@"photosetID"];
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newsItem];
    [_queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"insert into t_FNNewsDetail (detailId, dic) values(?,?);",detailId,data];
        
    }];
    [_queue close];
}

/**
 * 读取缓存
 */
+ (NSObject *)getStatusCache:(NSObject *)detailId
{
    [self setup];
    __block FMResultSet *rs = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        rs = [db executeQuery:@"select * from t_FNNewsDetail WHERE detailId = ?;",detailId];
    }];
    NSObject *status;
    if (rs.next) {
        status = [NSKeyedUnarchiver unarchiveObjectWithData:[rs dataForColumn:@"detailId"]];
    }
    [_queue close];
    return status;
}

@end
