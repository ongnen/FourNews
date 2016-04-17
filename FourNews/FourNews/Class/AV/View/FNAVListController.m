//
//  FNAVListController.m
//  FourNews
//
//  Created by admin on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVListController.h"
#import "FNAVGetAVNewsList.h"
#import "FNAVListCell.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FNNewsReplyController.h"
#import <MJRefresh.h>
#import "FNTabBarController.h"
#import "FNAVDetailController.h"
#import "FNAVViewController.h"

@interface FNAVListController ()

@property (nonatomic, assign) NSInteger refreshCount;

@property (nonatomic, strong) NSMutableArray<FNAVListItem *> *listItemArray;

@property (nonatomic, strong) AVPlayerViewController *playerVC;

@end

@implementation FNAVListController
static NSString * const ID = @"cell";
- (NSArray *)listItemArray
{
    if (!_listItemArray){
        self.listItemArray = [[NSMutableArray alloc] init];
    }
    return _listItemArray;
    
}

- (AVPlayerViewController *)playerVC
{
    if (!_playerVC) {
        _playerVC = [[AVPlayerViewController alloc] init];
    }
    return _playerVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(bottomDragRefreshData)];
    // 设置上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topDragRefreshData)];
    // 加载完直接刷新
    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FNAVListCell" bundle:nil] forCellReuseIdentifier:ID];
    
    // 右边内容条设置
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(YJNavBarMaxY+YJTitlesViewH, 0, YJTabBarH, 0);
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:FNTabBarButtonRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:FNTitleButtonRepeatClickNotification object:nil];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}


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

- (void)bottomDragRefreshData
{
    [FNAVGetAVNewsList getAVNewsListWithTid:self.tid :0 :^(NSArray *array) {
        self.listItemArray = (NSMutableArray *)array;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }];
}

- (void)topDragRefreshData
{
    [FNAVGetAVNewsList getAVNewsListWithTid:self.tid :++self.refreshCount :^(NSArray *array) {
        [self.listItemArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listItemArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FNAVListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.listItem = self.listItemArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.movieBlock = ^(NSString *urlStr,UIView *playerV){
        [self playMovieWithUrlStr:urlStr :playerV];
    };
    cell.replyBlock = ^(FNAVListItem *item){
        [self replyClickWithListItem:item];
    };
    return cell;
}
// 设置footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
// 设置footer样式
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footV = [[UIView alloc] init];
    footV.backgroundColor = FNColor(215, 215, 215);
    footV.bounds = CGRectMake(0, 0, FNScreenW, 10);
    return footV;
}

// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.listItemArray[indexPath.section].title;
    
    return [FNAVListCell totalHeightWithTitle:title];
}


- (void)playMovieWithUrlStr:(NSString *)urlStr :(UIView *)playerV
{
    [self.playerVC.player pause];
    _playerVC = nil;
    
    self.playerVC.showsPlaybackControls = YES;
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:urlStr]];
    self.playerVC.player = player;
    self.playerVC.view.frame = playerV.bounds;
    [playerV addSubview:self.playerVC.view];
    
    [self.playerVC.player play];
}

#pragma mark -  跳转评论界面
- (void)replyClickWithListItem:(FNAVListItem *)item
{
    // 1.跳转

    
    FNAVDetailController *avDetailVC = [[FNAVDetailController alloc] init];
    avDetailVC.item = item;
    avDetailVC.view.frame = CGRectMake(FNScreenW, 0, FNScreenW, FNScreenH);
    FNAVViewController *avVC = (FNAVViewController *)[self parentViewController];
    [avVC addChildViewController:avDetailVC];
    [avVC.view addSubview:avDetailVC.view];
    
    [UIView animateWithDuration:0.2 animations:^{
        avDetailVC.view.frame = CGRectMake(0, 0, FNScreenW, FNScreenH);
    }];
    
//    [self.navigationController pushViewController:avDetailVC animated:YES];
    
}















@end