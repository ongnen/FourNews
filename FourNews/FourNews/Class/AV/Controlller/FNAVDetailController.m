//
//  FNAVDetailController.m
//  FourNews
//
//  Created by xmg on 16/4/17.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVDetailController.h"
#import "FNNewsGetReply.h"
#import "FNNewsDetailItem.h"
#import <MJRefresh.h>
#import "FNNewsReplyItem.h"
#import "FNNewsReplyCell.h"
#import "FNNewsReplyButton.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#define FNAVMoviewHeight 250

@interface FNAVDetailController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UIView *movieView;

@property (nonatomic, weak) UITableView *replyView;

@property (nonatomic,assign) NSInteger newReplyPage;

@property (nonatomic,strong) NSMutableArray<NSArray *> *hReplys;

@property (nonatomic,strong) NSMutableArray<NSArray *> *nReplys;

@property (nonatomic, strong) AVPlayerViewController *playerVC;

@property (nonatomic, assign) CGPoint startP;

@property (nonatomic, assign ,getter=isInBottom) BOOL inBottom;

@property (nonatomic, strong) UIImageView *replyImgV;

@end

@implementation FNAVDetailController
static NSString * const ID = @"replyCell";

- (UIView *)movieView
{
    if (!_movieView) {
        UIView *moviewView = [[UIView alloc] init];
        moviewView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:moviewView];
        _movieView = moviewView;
    }
    return _movieView;
}

- (UITableView *)replyView
{
    if (!_replyView) {
         UITableView *replyView = [[UITableView alloc] init];
        replyView.delegate = self;
        replyView.dataSource = self;
        [self.view addSubview:replyView];
        _replyView = replyView;
    }
    return _replyView;
}
- (AVPlayerViewController *)playerVC
{
    if (!_playerVC) {
        _playerVC = [[AVPlayerViewController alloc] init];
    }
    return _playerVC;
}

- (UIImageView *)replyImgV
{
    if (!_replyImgV) {
        _replyImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, FNAVMoviewHeight, FNScreenW, FNScreenH-FNAVMoviewHeight)];
    }
    return _replyImgV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.replyView.frame = CGRectMake(0, FNAVMoviewHeight, FNScreenW, FNScreenH-FNAVMoviewHeight);
    self.movieView.frame = CGRectMake(0, 0, FNScreenW, FNAVMoviewHeight);
    
    self.replyView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topDragRefreshData)];
    [self bottomDragRefreshData];
    [self topDragRefreshData];
    
    [self setPlayerView];
    
}
#pragma mark - playerVC
- (void)setPlayerView
{
    self.playerVC.showsPlaybackControls = YES;
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:_item.mp4_url]];
    self.playerVC.player = player;
    self.playerVC.view.frame = self.movieView.bounds;
    [self.movieView addSubview:self.playerVC.view];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(playerVCPan:)];
    [self.movieView addGestureRecognizer:pan];
    [self.playerVC.player play];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)topDragRefreshData
{
    FNNewsDetailItem *item = [[FNNewsDetailItem alloc] init];
    item.docid = _item.replyid;
    item.replyBoard = _item.replyBoard;
    [FNNewsGetReply newReplyWithDetailItem:item :_newReplyPage :^(NSArray *array) {
        self.nReplys = (NSMutableArray *)array;
        [self.replyView.mj_footer endRefreshing];
        [self.replyView reloadData];
    }];
    _newReplyPage++;
}

- (void)bottomDragRefreshData
{
    FNNewsDetailItem *item = [[FNNewsDetailItem alloc] init];
    item.docid = _item.replyid;
    item.replyBoard = _item.replyBoard;
    [FNNewsGetReply hotReplyWithDetailItem:item :^(NSArray *array) {
        self.hReplys = (NSMutableArray *)array;
        [self.replyView reloadData];
    }];
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
    
    FNNewsReplyCell *cell = [self.replyView dequeueReusableCellWithIdentifier:ID];
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
// 设置footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
// 设置footer样式
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

#pragma mark - 手势

/** 拿到评论区截图 */
- (UIImage *)setDrawReplyImage
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(FNScreenW, FNScreenH-FNAVMoviewHeight), NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.replyView.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
    
}

- (void)playerVCPan:(UIPanGestureRecognizer *)pan
{
    self.view.transform = CGAffineTransformIdentity;
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startP = [pan locationInView:self.view];
        if (self.isInBottom) {
            self.view.frame = CGRectMake(FNScreenW/2, FNScreenH-FNAVMoviewHeight/2, FNScreenW/2, FNAVMoviewHeight/2);
        } else {
            self.view.frame = CGRectMake(0, 0, FNScreenW, FNAVMoviewHeight);
        }
        
        // 将评论区画出来并覆盖评论区
        self.replyImgV.image = [self setDrawReplyImage];
        [self.view addSubview:self.replyImgV];
        NSLog(@"%@",NSStringFromCGRect(self.replyImgV.frame));
    }
    
    CGPoint curP = [pan locationInView:self.view];
    CGFloat scale;
    CGFloat playerViewH = FNAVMoviewHeight;
    
    if (!self.isInBottom) { //  顶部视频
        CGPoint offset = CGPointMake(curP.x-self.startP.x, curP.y-self.startP.y);
        scale = (offset.x + offset.y)/500 > 0? (offset.x + offset.y)/500 : 0;
        if (scale>1) {
            scale = 1;
        }
        if (scale<0) {
            scale = 0;
        }
        CGFloat changeW = FNScreenW/2*scale;
        CGFloat changeH = (FNScreenH-playerViewH/2)*scale;
        self.view.layer.anchorPoint = CGPointMake(0, 0);
        self.view.layer.position = CGPointMake(0, 0);
        self.view.transform = CGAffineTransformMakeTranslation(changeW, changeH);
        self.view.transform = CGAffineTransformScale(self.view.transform, 1-scale/2, 1-scale/2);
    } else { // 底部视频
        
        CGPoint offset = CGPointMake(self.startP.x-curP.x, self.startP.y-curP.y);
        scale = (offset.x + offset.y)/500 > 0? (offset.x + offset.y)/500 : 0;
        if (scale>1) {
            scale = 1;
        }
        if (scale<0) {
            scale = 0;
        }
        
        self.view.layer.anchorPoint = CGPointMake(0, 0);
        self.view.layer.position = CGPointMake(FNScreenW/2, FNScreenH-playerViewH/2);
        self.view.transform = CGAffineTransformMakeTranslation(-FNScreenW/2*scale, -(FNScreenH-playerViewH/2)*scale);
        self.view.transform = CGAffineTransformScale(self.view.transform,1+scale, 1+scale);
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (scale>0.5) { // 缩放到目标位.
            if (self.inBottom) { // 从底部
                self.view.transform = CGAffineTransformIdentity;
                self.view.frame = CGRectMake(0, 0, FNScreenW, playerViewH);
                self.movieView.frame = CGRectMake(0, 0, FNScreenW, FNAVMoviewHeight);
                self.replyImgV.frame = CGRectMake(0, FNAVMoviewHeight, FNScreenW, FNScreenH-FNAVMoviewHeight);
                self.view.layer.anchorPoint = CGPointMake(0, 0);
                self.view.layer.position = CGPointMake(0, 0);
                self.view.transform = CGAffineTransformMakeTranslation(FNScreenW/2*(1-scale), (FNScreenH-playerViewH/2)*(1-scale));
                self.view.transform = CGAffineTransformScale(self.view.transform,(1+scale)/2, (1+scale)/2);
                [UIView animateWithDuration:0.3 animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.view.transform = CGAffineTransformScale(self.view.transform, 1, 1);
                    
                } completion:^(BOOL finished) {
                    self.inBottom = NO;
                    [self.replyImgV removeFromSuperview];
                }];
            } else { // 从顶部
                self.view.transform = CGAffineTransformIdentity;
                self.view.frame = CGRectMake(FNScreenW/2, FNScreenH-FNAVMoviewHeight/2, FNScreenW/2, playerViewH/2);
                self.movieView.frame = CGRectMake(0, 0, FNScreenW/2, FNAVMoviewHeight/2);
                self.replyImgV.frame = CGRectMake(0, FNAVMoviewHeight/2, FNScreenW/2, (FNScreenH-FNAVMoviewHeight)/2);
                self.view.layer.anchorPoint = CGPointMake(0, 0);
                self.view.layer.position = CGPointMake(FNScreenW/2, FNScreenH-playerViewH/2);
                self.view.transform = CGAffineTransformMakeTranslation(-FNScreenW/2*(1-scale), -(FNScreenH-playerViewH/2)*(1-scale));
                self.view.transform = CGAffineTransformScale(self.view.transform,(1-scale/2)*2, (1-scale/2)*2);
                [UIView animateWithDuration:0.3 animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.view.transform = CGAffineTransformScale(self.view.transform, 1, 1);
                } completion:^(BOOL finished) {
                    self.inBottom = YES;
                }];
            }
        }else{ // 缩放回原位
            if (self.inBottom) { // 从底部
                [UIView animateWithDuration:0.3 animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.view.transform = CGAffineTransformScale(self.view.transform, 1, 1);
                } completion:^(BOOL finished) {
                    self.inBottom = YES;
                }];
            } else { // 从顶部
                [UIView animateWithDuration:0.3 animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.view.transform = CGAffineTransformScale(self.view.transform, 1, 1);
                } completion:^(BOOL finished) {
                    self.inBottom = NO;
                    [self.replyImgV removeFromSuperview];
                }];
            }
            
        }
        
    }
}

//
//- (void)playerVCPan:(UIPanGestureRecognizer *)pan
//{
//    self.movieView.transform = CGAffineTransformIdentity;
//    if (pan.state == UIGestureRecognizerStateBegan) {
//        self.startP = [pan locationInView:self.view];
//        if (self.isInBottom) {
//            self.movieView.frame = CGRectMake(FNScreenW/2, FNScreenH-FNAVMoviewHeight/2, FNScreenW/2, FNAVMoviewHeight/2);
//        } else {
//            self.movieView.frame = CGRectMake(0, 0, FNScreenW, FNAVMoviewHeight);
//        }
//    }
//    
//    CGPoint curP = [pan locationInView:self.view];
//    CGFloat scale;
//    CGFloat playerViewH = FNAVMoviewHeight;
//    
//    if (!self.isInBottom) { //  顶部视频
//        CGPoint offset = CGPointMake(curP.x-self.startP.x, curP.y-self.startP.y);
//        scale = (offset.x + offset.y)/500 > 0? (offset.x + offset.y)/500 : 0;
//        if (scale>1) {
//            scale = 1;
//        }
//        if (scale<0) {
//            scale = 0;
//        }
//        CGFloat changeW = FNScreenW/2*scale;
//        CGFloat changeH = (FNScreenH-playerViewH/2)*scale;
//        self.movieView.layer.anchorPoint = CGPointMake(0, 0);
//        self.movieView.layer.position = CGPointMake(0, 0);
//        self.movieView.transform = CGAffineTransformMakeTranslation(changeW, changeH);
//        self.movieView.transform = CGAffineTransformScale(self.movieView.transform, 1-scale/2, 1-scale/2);
//    } else { // 底部视频
//        
//        CGPoint offset = CGPointMake(self.startP.x-curP.x, self.startP.y-curP.y);
//        scale = (offset.x + offset.y)/500 > 0? (offset.x + offset.y)/500 : 0;
//        if (scale>1) {
//            scale = 1;
//        }
//        if (scale<0) {
//            scale = 0;
//        }
//        
//        self.movieView.layer.anchorPoint = CGPointMake(0, 0);
//        self.movieView.layer.position = CGPointMake(FNScreenW/2, FNScreenH-playerViewH/2);
//        self.movieView.transform = CGAffineTransformMakeTranslation(-FNScreenW/2*scale, -(FNScreenH-playerViewH/2)*scale);
//        self.movieView.transform = CGAffineTransformScale(self.movieView.transform,1+scale, 1+scale);
//    }
//    
//    if (pan.state == UIGestureRecognizerStateEnded) {
//        if (scale>0.5) { // 缩放到目标位.
//            if (self.inBottom) { // 从底部
//                self.movieView.transform = CGAffineTransformIdentity;
//                self.movieView.frame = CGRectMake(0, 0, FNScreenW, playerViewH);
//                self.movieView.layer.anchorPoint = CGPointMake(0, 0);
//                self.movieView.layer.position = CGPointMake(0, 0);
//                self.movieView.transform = CGAffineTransformMakeTranslation(FNScreenW/2*(1-scale), (FNScreenH-playerViewH/2)*(1-scale));
//                self.movieView.transform = CGAffineTransformScale(self.movieView.transform,(1+scale)/2, (1+scale)/2);
//                [UIView animateWithDuration:0.3 animations:^{
//                    self.movieView.transform = CGAffineTransformMakeTranslation(0, 0);
//                    self.movieView.transform = CGAffineTransformScale(self.movieView.transform, 1, 1);
//                    
//                } completion:^(BOOL finished) {
//                    self.inBottom = NO;
//                }];
//            } else { // 从顶部
//                self.movieView.transform = CGAffineTransformIdentity;
//                self.movieView.frame = CGRectMake(FNScreenW/2, FNScreenH-FNAVMoviewHeight/2, FNScreenW/2, playerViewH/2);
//                self.movieView.layer.anchorPoint = CGPointMake(0, 0);
//                self.movieView.layer.position = CGPointMake(FNScreenW/2, FNScreenH-playerViewH/2);
//                self.movieView.transform = CGAffineTransformMakeTranslation(-FNScreenW/2*(1-scale), -(FNScreenH-playerViewH/2)*(1-scale));
//                self.movieView.transform = CGAffineTransformScale(self.movieView.transform,(1-scale/2)*2, (1-scale/2)*2);
//                [UIView animateWithDuration:0.3 animations:^{
//                    self.movieView.transform = CGAffineTransformMakeTranslation(0, 0);
//                    self.movieView.transform = CGAffineTransformScale(self.movieView.transform, 1, 1);
//                } completion:^(BOOL finished) {
//                    self.inBottom = YES;
//                }];
//            }
//        }else{ // 缩放回原位
//            if (self.inBottom) { // 从底部
//                [UIView animateWithDuration:0.3 animations:^{
//                    self.movieView.transform = CGAffineTransformMakeTranslation(0, 0);
//                    self.movieView.transform = CGAffineTransformScale(self.movieView.transform, 1, 1);
//                } completion:^(BOOL finished) {
//                    self.inBottom = YES;
//                }];
//            } else { // 从顶部
//                [UIView animateWithDuration:0.3 animations:^{
//                    self.movieView.transform = CGAffineTransformMakeTranslation(0, 0);
//                    self.movieView.transform = CGAffineTransformScale(self.movieView.transform, 1, 1);
//                } completion:^(BOOL finished) {
//                    self.inBottom = NO;
//                }];
//            }
//            
//        }
//        
//    }
//}



@end
