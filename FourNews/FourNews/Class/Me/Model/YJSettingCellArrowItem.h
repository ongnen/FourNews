//
//  YJSettingCellArrowItem.h
//  网易彩票2016
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJSettingCellBaseItem.h"

@interface YJSettingCellArrowItem : YJSettingCellBaseItem

//当是箭头是,告诉要跳转到哪一个类当中
@property (nonatomic ,assign) Class desClass;

@end
