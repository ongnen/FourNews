//
//  YJSettingTableViewCell.h
//  网易彩票2016
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJSettingCellBaseItem.h"

@interface YJSettingTableViewCell : UITableViewCell

+ (YJSettingTableViewCell *)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@property (nonatomic, strong) YJSettingCellBaseItem *item;

@end
