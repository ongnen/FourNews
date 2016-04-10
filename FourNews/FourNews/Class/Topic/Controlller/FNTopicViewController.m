//
//  TopicViewController.m
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicViewController.h"
#import "FNTopicGetListItem.h"
#import "FNTopicListCell.h"
#import <MJRefresh.h>
#import "FNTabBarController.h"

@interface FNTopicViewController()
@property (nonatomic, assign) NSInteger refreshCount;

@property (nonatomic, strong) NSMutableArray *listItems;

@end

@implementation FNTopicViewController
static NSString * const ID = @"cell";
- (NSMutableArray *)listItems
{
    if (!_listItems) {
        _listItems = [NSMutableArray array];
    }
    return _listItems;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    // 设置下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(bottomDragRefreshData)];
    // 设置上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topDragRefreshData)];
    // 加载完直接刷新
    [self.tableView.mj_header beginRefreshing];
    // 点击选项跳到顶部刷新
    FNTabBarController *tabBarVC = (FNTabBarController *)self.tabBarController;
    tabBarVC.newsBtnBlock = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"FNTopicListCell" bundle:nil] forCellReuseIdentifier:ID];
}

- (void)bottomDragRefreshData
{
    [FNTopicGetListItem getTopicNewsListWithPageCount:0 :^(NSArray *array) {
        self.listItems = (NSMutableArray*)array;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)topDragRefreshData
{
    [FNTopicGetListItem getTopicNewsListWithPageCount:++self.refreshCount :^(NSArray *array) {
        [self.listItems addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - datasource数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FNTopicListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.listItem = self.listItems[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 338;
}
// 设置footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
//// 设置footer样式
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footV = [[UIView alloc] init];
    footV.backgroundColor = FNColor(215, 215, 215);
    footV.bounds = CGRectMake(0, 0, FNScreenW, 10);
    NSLog(@"%@",NSStringFromCGRect(footV.frame));
    return footV;
}



@end
