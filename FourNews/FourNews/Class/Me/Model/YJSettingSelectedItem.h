//
//  YJSettingSelectedItem.h
//  FourNews
//
//  Created by admin on 16/5/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "YJSettingCellBaseItem.h"

@interface YJSettingSelectedItem : YJSettingCellBaseItem

//当是开关时,记录开关的状态
@property (nonatomic ,assign ,getter=isSelected) int selected;

@end
