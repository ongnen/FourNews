//
//  YJSettingGroupItem.m
//  网易彩票2016
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJSettingGroupItem.h"


@implementation YJSettingGroupItem

+ (instancetype)settingItemWithRowArray:(NSArray *)items {
    
    YJSettingGroupItem *groupItem = [[self alloc] init];
    groupItem.items = items;
    return groupItem;
}

@end
