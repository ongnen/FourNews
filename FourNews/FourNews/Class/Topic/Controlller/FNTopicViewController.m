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
#import "FNTopicDetailController.h"

@interface FNTopicViewController()
@property (nonatomic, assign) NSInteger refreshCount;

@property (nonatomic, strong) NSMutableArray *listItems;

@property (nonatomic, weak) UIImageView *plshdImgV;


@end

@implementation FNTopicViewController
static NSString * const ID = @"cell";
static NSString * const FOOT = @"footer";
- (NSMutableArray *)listItems
{
    if (!_listItems) {
        _listItems = [NSMutableArray array];
    }
    return _listItems;
}
- (UIImageView *)plshdImgV
{
    if (!_plshdImgV){
        UIImageView *placeholderImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_image_background"]];
        [self.view addSubview:placeholderImgV];
        [placeholderImgV sizeToFit];
        placeholderImgV.center = CGPointMake(FNScreenW/2, FNScreenH/2-100);
        _plshdImgV = placeholderImgV;
    }
    return _plshdImgV;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.plshdImgV];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(bottomDragRefreshData)];
    // 设置上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topDragRefreshData)];
    // 加载完直接刷新
    [self.tableView.mj_header beginRefreshing];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"FNTopicListCell" bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:FOOT];
    // 分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:FNTabBarButtonRepeatClickNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - tabBarButton被点击调用的方法
- (void)tabBarButtonRepeatClick
{
    // 不在当前窗口 返回
    if (self.view.window == nil) return;
    // 不再屏幕中间 返回
    if (self.tableView.scrollsToTop == NO) return;
    
    [self.tableView.mj_header beginRefreshing];
}
- (void)bottomDragRefreshData
{
    [FNTopicGetListItem getTopicNewsListWithPageCount:0 :^(NSArray *array) {
        [self.plshdImgV removeFromSuperview];

        self.listItems = (NSMutableArray*)array;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FNTopicListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.listItem = self.listItems[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 338;
}

#pragma mark - tableViewDatagete


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FNTopicDetailController *detailVc = [[FNTopicDetailController alloc] init];
    detailVc.listItem = _listItems[indexPath.row];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}



@end
