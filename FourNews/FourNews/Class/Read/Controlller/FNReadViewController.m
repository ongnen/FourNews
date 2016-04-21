//
//  ReadViewController.m
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNReadViewController.h"
#import "FNReadGetNewsListItem.h"
#import "FNReadListItem.h"
#import "FNReadListSglImgCell.h"
#import "FNReadChooseListCell.h"
#import "FNReadListThreeImgCell.h"
#import "FNNewsDetailController.h"
#import "FNNewsListItem.h"
#import "FNNewsGetDetailNews.h"
#import "FNNewsGetReply.h"

#import <MJRefresh.h>

@interface FNReadViewController ()

@property (nonatomic, strong) NSMutableArray<FNReadListItem *> *newsListArray;

@property (nonatomic, weak) UIImageView *plshdImgV;

@end

@implementation FNReadViewController
- (NSMutableArray *)newsListArray
{
    if (!_newsListArray) {
        NSMutableArray *arr = [NSMutableArray array];
        _newsListArray = arr;
    }
    
    return _newsListArray;
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.plshdImgV];
    // 设置刷新控件
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(bottomDragRefreshData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topDragRefreshData)];
    [self.tableView.mj_header beginRefreshing];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:FNTabBarButtonRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:FNTitleButtonRepeatClickNotification object:nil];
    
    // 右边滚动条设置
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(YJNavBarMaxY+YJTitlesViewH, 0, YJTabBarH, 0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
- (void)titleButtonRepeatClick
{
    // 不在当前窗口 返回
    if (self.view.window == nil) return;
    // 不再屏幕中间 返回
    if (self.tableView.scrollsToTop == NO) return;
    
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - 上下拉刷新的方法
- (void)bottomDragRefreshData
{
    [FNReadGetNewsListItem getNewsListItemsWithCount:1 :^(NSArray *array) {
        [self.plshdImgV removeFromSuperview];
        self.newsListArray = (NSMutableArray *)array;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }];
}
- (void)topDragRefreshData
{
    [FNReadGetNewsListItem getNewsListItemsWithCount:1 :^(NSArray *array) {
        [self.newsListArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.newsListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FNReadListItem *item = self.newsListArray[indexPath.row];
    
    id cell = [FNReadChooseListCell cellWithItem:item :tableView];
    [cell setItem:item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FNReadListItem *item = self.newsListArray[indexPath.row];
    // cellHeight清零
    item.cellHeight = 0;
    
    return  item.cellHeight;
}


#pragma mark - 监听cell的点击 跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 点击cell后
    // 1.拿到详情页的网络数据
    // 2.跳转到详情控制器
    // 3.详情控制器拿到数据进行数据展示
    
    
    FNReadListItem *listItem = self.newsListArray[indexPath.row];
    
    // 1.跳转
    FNNewsDetailController *detailVC = [[FNNewsDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.listItem = (FNNewsListItem *)listItem;
    // 传数据
    [FNNewsGetDetailNews getNewsDetailWithDocid:listItem.docid :^(FNNewsDetailItem *item) {
        [FNNewsGetReply hotReplyWithDetailItem:item :^(NSArray *array) {
            if (array == nil) {
            } else {
                item.replys = array;
            }
            detailVC.detailItem = item;
            
        }];
        
    }];
}



@end
