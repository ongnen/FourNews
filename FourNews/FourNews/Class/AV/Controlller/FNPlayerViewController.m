//
//  FNPlayerViewController.m
//  FourNews
//
//  Created by xmg on 16/4/15.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface FNPlayerViewController ()

@end

@implementation FNPlayerViewController
static FNPlayerViewController *_playerVC;
+ (instancetype)sharePlayerViewController
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (_playerVC == nil) {
            _playerVC = [super allocWithZone:zone];
        }
    }
    return _playerVC;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _playerVC;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _playerVC;
}

@end
