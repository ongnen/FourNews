//
//  YJSettingTableViewCell.m
//  网易彩票2016
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJSettingTableViewCell.h"
#import "YJSettingCellArrowItem.h"
#import "YJSettingCellSwitchItem.h"
#import "FNUserDefaults.h"
#import "YJSettingSelectedItem.h"

@interface YJSettingTableViewCell()

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIImageView *hookView;

@end

@implementation YJSettingTableViewCell

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowView;
}
- (UIImageView *)hookView
{
    if (_hookView == nil) {
        _hookView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"modalview_donebutton"]];
    }
    return _hookView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

//创建一个cell
+ (YJSettingTableViewCell *)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    
    static NSString *ID = @"settingCell";
    YJSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YJSettingTableViewCell alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(YJSettingCellBaseItem *)item
{
    _item = item;
    // 1.设置数据
    [self setData];
    
    // 2.设置箭头和按钮
    [self setRightContent];
}

- (void)setData
{
    if (self.item.image) {
        self.imageView.image = self.item.image;
    }
    self.textLabel.text = self.item.title;
    self.detailTextLabel.text = self.item.detailTitle;
}

- (void)setRightContent
{
    // 1.
    if ([self.item isKindOfClass:[YJSettingCellArrowItem class]]) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryView = self.arrowView;
        // 2.
    }else if([self.item isKindOfClass:[YJSettingCellSwitchItem class]]){
        self.detailTextLabel.text = nil;
        // 取出设置switch的状态
        self.switchView.on = [FNUserDefaults boolForKey:self.item.title];
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 3.
    } else if ([self.item isKindOfClass:[YJSettingSelectedItem class]]) {
        YJSettingSelectedItem *selecItem = (YJSettingSelectedItem*)self.item;
        self.accessoryView = self.hookView;
        if (selecItem.isSelected) {
            self.accessoryView.hidden = NO;
        } else {
            self.accessoryView.hidden = YES;
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}
- (void)switchChange:(UISwitch *)switchBtn
{
    [FNUserDefaults setBool:switchBtn.isOn forKey:self.item.title];
}



@end
