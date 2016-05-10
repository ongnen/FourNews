//
//  YJSettingCelBaseItem.m
//  网易彩票2016
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJSettingCellBaseItem.h"

@implementation YJSettingCellBaseItem

//快速创建模型
+ (instancetype)settingRowItemWithTitle:(NSString *)title image:(UIImage *)image {
    
    YJSettingCellBaseItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    return item;
}

@end
