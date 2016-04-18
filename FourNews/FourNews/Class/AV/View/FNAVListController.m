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

@property (nonatomic, strong) NSIndexPath *previousIndexPath;

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
    AVAudioSession *session = [AVAudioSession sharedInstance];
    self.tableView.rowHeight = 290;
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FNAVListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.listItem = self.listItemArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.movieBlock = ^(NSString *urlStr,UIView *playerV){
        [self playMovieWithUrlStr:urlStr :playerV];
    };
    cell.replyBlock = ^(FNAVListItem *item){
        [self replyClickWithListItem:item];
    };
    return cell;
}

- (void)playMovieWithUrlStr:(NSString *)urlStr :(UIView *)playerV
{
    
    if (self.previousIndexPath) {
        [self.tableView reloadRowsAtIndexPaths:@[self.previousIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    playerV.subviews.count ? [playerV.subviews[0] removeFromSuperview] : playerV.subviews.count;
    [self.playerVC.player pause];
    _playerVC = nil;
    
    self.playerVC.view.translatesAutoresizingMaskIntoConstraints = YES;
    self.playerVC.showsPlaybackControls = YES;
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:urlStr]];
    self.playerVC.player = player;
    self.playerVC.view.frame = playerV.bounds;
    [playerV addSubview:self.playerVC.view];
    
    [self.playerVC.player play];
    
    NSIndexPath *indexPath;
    for (int i = 0; i<self.listItemArray.count; i++) {
        if ([self.listItemArray[i].mp4_url isEqualToString:urlStr]) {
            indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        }
    }
    
    self.previousIndexPath = indexPath;
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