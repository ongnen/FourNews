//
//  FNNewsReplyController.m
//  FourNews
//
//  Created by xmg on 16/4/4.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsReplyController.h"
#import "FNNewsGetReply.h"
#import "FNNewsDetailItem.h"
#import "FNNewsReplyCell.h"
#import "FNNewsReplyButton.h"

#import <MJRefresh.h>
@interface FNNewsReplyController ()

@property (nonatomic,strong) NSMutableArray<NSArray *> *hReplys;

@property (nonatomic,strong) NSMutableArray<NSArray *> *nReplys;

@property (nonatomic,assign) NSInteger newReplyPage;

@property (nonatomic, weak) UIImageView *bottonImgV;

@property (nonatomic, assign) BOOL isFirstScroll;


@end

@implementation FNNewsReplyController
static NSString * const ID = @"replyCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setReplyData];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topDragRefreshData)];
    [self.tableView.mj_footer beginRefreshing];
    
    [self setBottomImgV];
}

- (void)topDragRefreshData
{
    [FNNewsGetReply newReplyWithDetailItem:_item :_newReplyPage :^(NSArray *array) {
        self.nReplys = (NSMutableArray *)array;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
    _newReplyPage++;
}

- (void)setReplyData
{
    FNNewsDetailItem *item = [[FNNewsDetailItem alloc] init];
    item.docid = _docid;
    item.replyBoard = _boardid;
    _item = item;
    [FNNewsGetReply hotReplyWithDetailItem:item :^(NSArray *array) {
        self.hReplys = (NSMutableArray *)array;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hReplys.count;
    } else {
        return self.nReplys.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FNNewsReplyCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[FNNewsReplyCell alloc] init];
    }
    FNNewsReplyItem *replyItem;
    if (indexPath.section == 0) {
        replyItem = self.hReplys[indexPath.row].lastObject;
    } else {
        replyItem = self.nReplys[indexPath.row].lastObject;
    }
    cell.replyItem = replyItem;
    
    return cell;
}

// 设置header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
// 设置header样式
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerV = [[UIView alloc] init];
    
    headerV.frame = CGRectMake(0, 0, FNScreenW, 20);
    
    headerV.backgroundColor = [UIColor clearColor];
    
    FNNewsReplyButton *replyBtn = [[FNNewsReplyButton alloc] init];
    replyBtn.frame = CGRectMake(0, 0, 70, 20);
    replyBtn.backgroundColor = [UIColor redColor];
    replyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    if (section == 0) {
        [replyBtn setTitle:@"最热评论" forState:UIControlStateNormal];
    } else {
        [replyBtn setTitle:@"最新评论" forState:UIControlStateNormal];
    }
    [headerV addSubview:replyBtn];
    return headerV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FNNewsReplyItem *replyItem;
    if (indexPath.section == 0) {
        replyItem = self.hReplys[indexPath.row].lastObject;
        return [FNNewsReplyCell totalHeightWithItem:replyItem];
    } else {
        replyItem = self.nReplys[indexPath.row].lastObject;
        return [FNNewsReplyCell totalHeightWithItem:replyItem];
    }
}
#pragma  mark - 设置底部仿真图片
- (void)setBottomImgV
{
    UIImageView *bottomImgV = [[UIImageView alloc] init];
    bottomImgV.image = [UIImage imageNamed:@"detailBottomBackGround"];
    bottomImgV.frame = CGRectMake(0, self.view.height-FNBottomBarHeight-FNTopBarHeight+FNStateBarHeight+100, FNScreenW, FNBottomBarHeight);
    [self.view addSubview:bottomImgV];
    self.bottonImgV = bottomImgV;
//    NSLog(@"%@",NSStringFromCGPoint(self.view.frame.origin));
}

#pragma mark - 设置底部图片相对不移动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bottomImgY = self.isFirstScroll ? self.view.height-FNTopBarHeight+FNStateBarHeight+scrollView.contentOffset.y : self.view.height-FNTopBarHeight+scrollView.contentOffset.y+2*FNStateBarHeight;
    self.bottonImgV.frame = CGRectMake(0, bottomImgY, FNScreenW, FNBottomBarHeight);

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isFirstScroll = YES;
}


@end
