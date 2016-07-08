//
//  FNHTTPManager.m
//  FourNews
//
//  Created by xmg on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNHTTPManager.h"

@implementation FNHTTPManager
static AFHTTPSessionManager *manager ;

+ (AFHTTPSessionManager *)sharedHTTPSession{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
    });
    return manager;
}
+ (instancetype)manager
{
    FNHTTPManager *mgr = (FNHTTPManager *)[FNHTTPManager sharedHTTPSession];
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = mgr.responseSerializer.acceptableContentTypes;
    
    // 添加额外类型
    [mgrSet addObject:@"text/html"];
    
    mgr.responseSerializer.acceptableContentTypes = mgrSet;
    
    return mgr;
}

@end
