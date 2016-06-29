//
//  FNNewsListController.m
//  FourNews
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsListController.h"
#import "FNNewsListItem.h"
#import "FNGetNewsListDatas.h"
#import "FNNewsSglImgCell.h"
#import "FNNewsThrImgCell.h"
#import "FNGetListCell.h"
#import "FNTabBarController.h"
#import "FNNewsDetailController.h"
#import "FNNewsGetDetailNews.h"
#import "FNNewsGetReply.h"
#import "FNNewsPhotoSetController.h"
#import "FNNewsGetPhotoSetItem.h"
#import "FNNewsADView.h"
#import "FNNewsADsItem.h"
#import <AFNetworking.h>
#import <MJRefresh.h>


@interface FNNewsListController ()

@property (nonatomic, strong) NSMutableArray<FNNewsListItem *> *newsListArray;

@property (nonatomic, assign) NSInteger refreshCount;

@property (nonatomic, strong) NSArray *replyArray;

@property (nonatomic, weak) UIImageView *plshdImgV;

@property (nonatomic, assign) NSInteger lastTimeid;
@property (nonatomic, assign) BOOL isReady;
@end

@implementation FNNewsListController

- (void)loadView
{
    [super loadView];
}

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.plshdImgV];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.refreshCount = 1;
    // 初始化
    _isReady = YES;
    // 设置估算高度，减少heightForRowAtIndexPath调用频率
    self.tableView.estimatedRowHeight = 100.0;
    // 设置刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(bottomDragRefreshData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topDragRefreshData)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self launchRefresh];
        
    });
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:FNTabBarButtonRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:FNNewsTitleButtonRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isReadyChange) name:FNRefreshReady object:nil];
    
    // 右边内容条设置
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(YJNavBarMaxY+YJTitlesViewH, 0, YJTabBarH, 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//    
//    if (mgr.isReachable) {
//        [self.tableView.mj_header beginRefreshing];
//    } else {
//        [self.tableView.mj_header beginRefreshing];
//        [UILabel label].text = @"暂无网络";
//    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 广告

- (void)setADHeaderView
{
    if (self.newsListArray.count==0) return;
    FNNewsListItem *item = self.newsListArray[0];
    if (item.ads) {
        FNNewsADView *adView = [[NSBundle mainBundle] loadNibNamed:@"FNNewsADView" owner:nil options:0].lastObject;
        adView.height = 200;
        adView.contItem = item;
        adView.adClickBlock = ^(FNNewsListItem *listItem,NSInteger index){
            [self showPhotoSetWith:listItem :index];
        };
        self.tableView.tableHeaderView = adView;
    }
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
    
    // 防止数据返回前重复刷新
    if (_isReady == YES) {
        [self.tableView.mj_header beginRefreshing];
        _isReady = NO;
    }
    
}
#pragma mark - 上下拉刷新的方法
- (void)bottomDragRefreshData
{
    [FNGetNewsListDatas getNewsListItemsWithProgramaid:self.pgmid :1 :self.lastTimeid :^(NSArray *array) {
        [self.plshdImgV removeFromSuperview];
        
        if (array) {
            [self.newsListArray removeAllObjects];
            [self.newsListArray addObjectsFromArray:array];
        }
        [self.tableView.mj_header endRefreshing];
        
        if (self.newsListArray.count == 0)return ;
        // 设置广告
        [self setADHeaderView];
        
        [self.tableView reloadData];
        // 设置timeid
        self.lastTimeid = self.newsListArray.lastObject.timeid;
    }];
}
- (void)topDragRefreshData
{
    [FNGetNewsListDatas getNewsListItemsWithProgramaid:self.pgmid :++self.refreshCount :self.lastTimeid :^(NSArray *array) {
        [self.newsListArray addObjectsFromArray:(NSMutableArray *)array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        // 设置timeid
        self.lastTimeid = self.newsListArray.lastObject.timeid;
    }];
}
// 启动时的刷新不需要显示上拉控件
- (void)launchRefresh
{
    [FNGetNewsListDatas getNewsListItemsWithProgramaid:self.pgmid :1 :self.lastTimeid :^(NSArray *array) {
        [self.newsListArray addObjectsFromArray:array];
        // 设置广告
        [self setADHeaderView];
        // 设置timeid
        self.lastTimeid = self.newsListArray.lastObject.timeid;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    self.tableView.mj_header.hidden = !self.newsListArray.count;
    return self.newsListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FNNewsListItem *item = self.newsListArray[indexPath.row];

    id cell = [FNGetListCell cellWithTableView:tableView :item :indexPath];
    [cell setContItem:item];


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FNNewsListItem *item = self.newsListArray[indexPath.row];
    
    return item.totalHeight;
}

#pragma mark - 监听cell的点击 跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 点击cell后
    // 1.拿到详情页的网络数据
    // 2.跳转到详情控制器
    // 3.详情控制器拿到数据进行数据展示
    
    
    FNNewsListItem *listItem = self.newsListArray[indexPath.row];
    if (listItem.photosetID) {
        FNNewsPhotoSetController *photoSetVC = [[FNNewsPhotoSetController alloc] init];
        photoSetVC.photoSetid = listItem.photosetID;
        photoSetVC.listItem = listItem;
        [self.navigationController pushViewController:photoSetVC animated:YES];
        
    } else {
        // 1.跳转
        FNNewsDetailController *detailVC = [[FNNewsDetailController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
        detailVC.listItem = listItem;
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
}
/** 跳转图集控制器 */
- (void)showPhotoSetWith:(FNNewsListItem *)listItem :(NSInteger)index
{
    FNNewsPhotoSetController *photoSetVC = [[FNNewsPhotoSetController alloc] init];
    FNNewsADsItem *item = listItem.ads[index];
    photoSetVC.photoSetid = item.url;
    photoSetVC.listItem = listItem;
    [self.navigationController pushViewController:photoSetVC animated:YES];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)isReadyChange
{
    _isReady = YES;
}
@end
