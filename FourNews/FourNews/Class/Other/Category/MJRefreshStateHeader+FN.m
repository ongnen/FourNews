//
//  MJRefreshStateHeader+FN.m
//  FourNews
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "MJRefreshStateHeader+FN.h"
#import <AFNetworking.h>

@implementation MJRefreshStateHeader (FN)

- (void)prepare
{
    [super prepare];
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [self setTitle:MJRefreshHeaderPullingText forState:MJRefreshStatePulling];
    if (mgr.isReachable) {
        // 初始化文字
        [self setTitle:MJRefreshHeaderIdleText forState:MJRefreshStateIdle];
        [self setTitle:MJRefreshHeaderRefreshingText forState:MJRefreshStateRefreshing];
    } else {
//        [self setTitle:@"暂无网络，为您展示缓存数据" forState:MJRefreshStateIdle];
        [self setTitle:@"暂无网络，为您展示缓存数据" forState:MJRefreshStateRefreshing];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNetInvalidTip) name:FNNewsNetInvalid object:nil];
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setNetInvalidTip {
//    [self setTitle:@"暂无网络" forState:MJRefreshStateIdle];
//    [self setTitle:@"暂无网络" forState:MJRefreshStateRefreshing];
}
@end
