//
//  YJSetUpBaseController.h
//  01彩票
//
//  Created by admin on 15/11/30.
//  Copyright (c) 2015年 梅三IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJSettingGroupItem.h"
#import "YJSettingTableViewCell.h"
#import "YJSettingCellArrowItem.h"
#import "YJSettingCellSwitchItem.h"
#import "YJSettingSelectedItem.h"

@interface YJSettingBaseController : UITableViewController

@property (nonatomic, strong) NSMutableArray *groupArray;

@end
