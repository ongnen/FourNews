//
//  FNStatusCacheTool.m
//  FourNews
//
//  Created by admin on 16/5/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNStatusCacheTool.h"
#import <FMDB.h>

@implementation FNStatusCacheTool

static FMDatabaseQueue *_queue;

+ (void)setupWithName:(NSString *)tName
{
    // 1.在沙盒中创建数据库文件
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    // 2.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:file];
    
    // 3.创表
    [_queue inDatabase:^(FMDatabase *db) { // 这句代码内部包含了创建数据库实例
        [db executeUpdate:[NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, timeid integer, dic blob, isread real);",tName]];
    }];
}

/**
 * 缓存数据的方法
 */
+ (void)addStatusCache:(NSArray *)dicArray :(NSString *)tName
{
    NSString *t_name = [NSString stringWithFormat:@"t_%@",tName];
    [self setupWithName:t_name];
    
    for (NSObject *status in dicArray) {
        NSInteger pTimeid = (long)[status valueForKey:@"timeid"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_queue inDatabase:^(FMDatabase *db) {
            
            [db executeUpdate:[NSString stringWithFormat:@"insert into %@ (timeid, dic,isread) values(?,?,1);",t_name],pTimeid,data];
            [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET isread = 1 where timeid = %ld;",tName,pTimeid]];
            // 删除重复记录
            [db executeUpdate:[NSString stringWithFormat:@"delete from %@ where id not in(select max(id) from %@ group by timeid)",t_name,t_name]];
        }];
    }
    [_queue close];
}
/**
 * 读取数据的方法
 */
+ (NSMutableArray *)getStatusCache:(FNStatusParamModel *)params
{
    NSString *t_name = [NSString stringWithFormat:@"t_%@",params.modelName];
    [self setupWithName:t_name];
    __block NSMutableArray *statusArray = [NSMutableArray array];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 读取数据库
        __block FMResultSet *rs = nil;
        if (params.timeid == 0) {
            NSString *sql = [NSString stringWithFormat:@"select * from %@ WHERE isread IN (SELECT * FROM %@ WHERE isread = 0) and timeid > %ld ORDER BY timeid DESC LIMIT 0,%ld;",t_name,t_name,params.timeid,params.count];
            // 为读取的数据加阅读记录
            NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET isread = 1 WHERE WHERE isread = 0 ORDER BY timeid DESC LIMIT 0,%ld;",t_name,params.count];
            
            rs = [db executeQuery:sql];
            
            [db executeUpdate:sql1];
            
        } else {
            NSString *sql = [NSString stringWithFormat:@"select * from %@ WHERE isread = 0 ORDER BY timeid DESC LIMIT 0,%ld;",t_name,params.count];
            rs = [db executeQuery:sql];
        }
        
        while (rs.next) {
            // 将data转为字典
            NSObject *status = [NSKeyedUnarchiver unarchiveObjectWithData:[rs dataForColumn:@"dic"]];
            // 存入数组
            [statusArray addObject:status];
        }
    }];
    if (params.timeid != 0) {
        // 给取出的数据添加阅读记录
        [_queue inDatabase:^(FMDatabase *db) {
            NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET isread = 1 WHERE isread = 0 ORDER BY timeid DESC LIMIT 0,%ld;",t_name,params.count];
            [db executeUpdate:sql1];
        }];
        
    }
    
    [_queue close];
    return (NSMutableArray *)statusArray;
}
// 全部标记为未读
+ (void)setOriginReadSkimWithName:(NSString *)tName
{
    NSString *t_name = [NSString stringWithFormat:@"t_%@",tName];
    [self setupWithName:t_name];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 注意： 一定要自己拼接数据库语句
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET isread = 0;",t_name];
        [db executeUpdate:sql];
    }];
}

@end
