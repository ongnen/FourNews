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
#import <MJRefresh.h>

@interface FNNewsListController ()

@property (nonatomic, strong) NSMutableArray *newsListArray;

@property (nonatomic, assign) NSInteger refreshCount;

@property (nonatomic, strong) NSArray *replyArray;

@end

@implementation FNNewsListController


- (NSMutableArray *)newsListArray
{
    if (!_newsListArray) {
        NSMutableArray *arr = [NSMutableArray array];
        _newsListArray = arr;
    }
    
    return _newsListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshCount = 1;
    self.tableView.rowHeight = 90;
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(bottomDragRefreshData)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topDragRefreshData)];
    
    [self.tableView.mj_header beginRefreshing];
    
    FNTabBarController *tabBarVC = (FNTabBarController *)self.tabBarController;
    tabBarVC.newsBtnBlock = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    
}

- (void)bottomDragRefreshData
{
    [FNGetNewsListDatas getNewsListItemsWithProgramaid:self.pgmid :1 :^(NSArray *array) {
        [self.tableView.mj_header endRefreshing];
        self.newsListArray = (NSMutableArray *)array;
        [self.tableView reloadData];
        
    }];
}

- (void)topDragRefreshData
{
    [FNGetNewsListDatas getNewsListItemsWithProgramaid:self.pgmid :++self.refreshCount :^(NSArray *array) {
        [self.newsListArray addObjectsFromArray:(NSMutableArray *)array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    if (indexPath.row == 0 && item.ads) {
        return 200;
    } else if (item.imgextra) {
        return 120;
    } else {
        return 90;
    }
}

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

@end
