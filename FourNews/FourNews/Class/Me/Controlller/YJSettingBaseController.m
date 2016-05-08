//
//  YJSettingController.m
//  01彩票
//
//  Created by admin on 15/11/29.
//  Copyright (c) 2015年 梅三IT. All rights reserved.
//

#import "YJSettingBaseController.h"



@interface YJSettingBaseController()

@end

@implementation YJSettingBaseController
- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (NSMutableArray *)groupArray
{
    if (!_groupArray){
        self.groupArray = [[NSMutableArray alloc] init];
    }
    return _groupArray;
}

#pragma mark tableView的数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.groupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YJSettingGroupItem *group = self.groupArray[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    YJSettingTableViewCell *cell = [YJSettingTableViewCell cellWithTableView:tableView style:UITableViewCellStyleValue1];
    // 2.传入数据
    YJSettingGroupItem *group = self.groupArray[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    // 3.返回cell
    return cell;
}
#

#pragma mark tableView的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取消选中这行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 2.执行其他操作
    YJSettingGroupItem *group = self.groupArray[indexPath.section];
    YJSettingCellBaseItem *item = group.items[indexPath.row];
    if (item.option) {
        item.option();
    }
    if ([item isKindOfClass:[YJSettingCellArrowItem class]]) {
        YJSettingCellArrowItem *arrowItem = (YJSettingCellArrowItem *)item;
        UIViewController *vc = [[arrowItem.desClass alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    YJSettingGroupItem *group = self.groupArray[section];
    return group.headerT;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    YJSettingGroupItem *group = self.groupArray[section];
    return group.footerT;
}
#


@end
