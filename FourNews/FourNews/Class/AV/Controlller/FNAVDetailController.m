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
#import "FNAVViewController.h"
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

@property (nonatomic, weak) UIButton *backBtn;

@property (nonatomic, weak) UIView *beddingView;

@property (nonatomic, assign) CGPoint firstOffset;

@end

@implementation FNAVDetailController
static NSString * const ID = @"replyCell";

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

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
        [self.beddingView addSubview:replyView];
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

- (UIView *)beddingView
{
    if (!_beddingView){
        UIView *beddingView = [[UIView alloc] init];
        [self.view addSubview:beddingView];
        _beddingView = beddingView;
    }
    return _beddingView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.beddingView.frame = CGRectMake(0, FNAVMoviewHeight, FNScreenW, FNScreenH-FNAVMoviewHeight);
    self.replyView.frame = CGRectMake(0, 0, FNScreenW, FNScreenH-FNAVMoviewHeight);
    self.movieView.frame = CGRectMake(0, 0, FNScreenW, FNAVMoviewHeight);
    
    self.replyView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topDragRefreshData)];
    [self bottomDragRefreshData];
    [self topDragRefreshData];
    
    [self setPlayerView];
    
    [self setBackButton];
    
}


#pragma mark - 返回
- (void)setBackButton
{
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"weather_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(5, 5, 40, 40);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.movieView addSubview:backBtn];
    self.backBtn = backBtn;
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
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    
//}

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


/** 拿到评论区截图 */
- (UIImage *)setDrawReplyImage
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(FNScreenW, FNScreenH-FNAVMoviewHeight), NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.beddingView.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
    
}

#pragma mark - 手势 缩放，滑动删除
- (void)playerVCPan:(UIPanGestureRecognizer *)pan
{
    self.view.transform = CGAffineTransformIdentity;
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.backBtn.hidden = YES;
        self.startP = [pan locationInView:self.view];
        if (self.isInBottom) {
            self.view.frame = CGRectMake(FNScreenW/2, FNScreenH-FNAVMoviewHeight/2-YJTabBarH, FNScreenW/2, FNScreenH/2);
            FNAVViewController *avVC = (FNAVViewController *)[self parentViewController];
            // 1.跳转.
            // 用画的图片遮盖
            UIImageView *screenImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FNScreenW, YJNavBarMaxY+YJTitlesViewH)];
            screenImgV.image = [self drawScreen];
            [avVC.view insertSubview:screenImgV belowSubview:self.view];
            avVC.screenImgV = screenImgV;
            self.navigationController.navigationBarHidden = YES;
        } else {
            // 将评论区画出来并覆盖评论区
            self.replyImgV.image = [self setDrawReplyImage];
            [self.view addSubview:self.replyImgV];
            self.view.frame = CGRectMake(0, 0, FNScreenW, FNScreenH);
            NSData *data = UIImagePNGRepresentation([self setDrawReplyImage]);
                    [data writeToFile:[NSString stringWithFormat:@"/Users/admin/Desktop/imag.png"]atomically:YES];
        }
        
        // 将评论区变透明
        self.view.backgroundColor = [UIColor clearColor];
        self.replyView.alpha = 0;
    }
    
    CGPoint curP = [pan locationInView:self.view];
    CGFloat scale;
    CGFloat playerViewH = FNAVMoviewHeight;
    
    // 评论区渐变透明
    self.replyImgV.alpha = 1-scale;
    
    if (!self.isInBottom) { //  顶部视频
        
        CGPoint offset = CGPointMake(curP.x-self.startP.x, curP.y-self.startP.y);
        scale = (offset.x + offset.y)/500 > 0? (offset.x + offset.y)/500 : 0;
        if (scale > 1) {
            scale = 1;
        }
        if (scale < 0) {
            scale = 0;
        }
        CGFloat changeW = FNScreenW/2*scale;
        CGFloat changeH = (FNScreenH-playerViewH/2-YJTabBarH)*scale;
        self.view.layer.anchorPoint = CGPointMake(0, 0);
        self.view.layer.position = CGPointMake(0, 0);
        self.view.transform = CGAffineTransformMakeTranslation(changeW, changeH);
        self.view.transform = CGAffineTransformScale(self.view.transform, 1-scale/2, 1-scale/2);
        
        // 评论区渐变透明
        self.replyImgV.alpha = 1-scale;
    } else { // 底部视频
        // 评论区渐变实体
        self.replyImgV.alpha = scale;
        CGPoint offset = CGPointMake(self.startP.x-curP.x, self.startP.y-curP.y);
        scale = (offset.x + offset.y)/500 > 0? (offset.x + offset.y)/500 : 0;
        if (scale > 1) {
            scale = 1;
        }
        if (scale < 0) {
            scale = 0;
        }
        // 拿到第一个有效的能判断是否左滑的offset
        if (fabs(offset.x) > offset.y && self.firstOffset.x == 0 && self.firstOffset.y == 0) {
            self.firstOffset = offset;
        }
        if (fabs(self.firstOffset.x)>self.firstOffset.y) { // 左滑删除
            self.view.layer.anchorPoint = CGPointMake(0, 0);
            self.view.layer.position = CGPointMake(FNScreenW/2, FNScreenH-playerViewH/2-YJTabBarH);
            self.view.transform = CGAffineTransformMakeTranslation(-offset.x, 0);
            // 改变透明度
            self.view.alpha = 1-fabs(offset.x)/FNScreenW;
        } else { // 上滑放大
            self.view.layer.anchorPoint = CGPointMake(0, 0);
            self.view.layer.position = CGPointMake(FNScreenW/2, FNScreenH-playerViewH/2-YJTabBarH);
            self.view.transform = CGAffineTransformMakeTranslation(-FNScreenW/2*scale, -(FNScreenH-playerViewH/2-YJTabBarH)*scale);
            
            self.view.transform = CGAffineTransformScale(self.view.transform,1+scale, 1+scale);
        }
        
        
        // 评论区渐变实体
        self.replyImgV.alpha = scale;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint offset = CGPointMake(self.startP.x-curP.x, self.startP.y-curP.y);
        // 判断是否是小窗口左右滑动
        if (self.firstOffset.x) {
            if (scale > 0.2) { // 左滑删除
                self.view.transform = CGAffineTransformIdentity;
                self.view.frame = CGRectMake(-FNScreenW/2, FNScreenH-FNAVMoviewHeight/2-YJTabBarH, FNScreenW/2, playerViewH/2);
                
                self.view.layer.anchorPoint = CGPointMake(0, 0);
                self.view.layer.position = CGPointMake(-FNScreenW/2, FNScreenH-playerViewH/2-YJTabBarH);
                self.view.transform = CGAffineTransformMakeTranslation(FNScreenW*(1-fabs(offset.x)/FNScreenW), 0);
                [UIView animateWithDuration:0.3 animations:^{
                    self.view.alpha = 0.001;
                    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.view.transform = CGAffineTransformScale(self.view.transform, 1, 1);
                    
                } completion:^(BOOL finished) {
                    FNAVViewController *avVC = (FNAVViewController *)[self parentViewController];
                    avVC.navigationController.navigationBarHidden = NO;
                    [avVC.screenImgV removeFromSuperview];
                    
                    [self.view removeFromSuperview];
                    [self removeFromParentViewController];
                }];
                return;
            } else if (offset.x < -FNScreenW/8) {  // 右滑删除
                self.view.transform = CGAffineTransformIdentity;
                self.view.frame = CGRectMake(FNScreenW, FNScreenH-FNAVMoviewHeight/2-YJTabBarH, FNScreenW/2, playerViewH/2);
                
                self.view.layer.anchorPoint = CGPointMake(0, 0);
                self.view.layer.position = CGPointMake(FNScreenW, FNScreenH-playerViewH/2-YJTabBarH);
                self.view.transform = CGAffineTransformMakeTranslation(-FNScreenW/2*(1-fabs(offset.x)/(FNScreenW/2)), 0);
                [UIView animateWithDuration:0.2 animations:^{
                    self.view.alpha = 0.001;
                    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.view.transform = CGAffineTransformScale(self.view.transform, 1, 1);
                    
                } completion:^(BOOL finished) {
                    FNAVViewController *avVC = (FNAVViewController *)[self parentViewController];
                    avVC.navigationController.navigationBarHidden = NO;
                    [avVC.screenImgV removeFromSuperview];
                    
                    [self.view removeFromSuperview];
                    [self removeFromParentViewController];
                }];
                return;
            }
        }
        
        
        
        if (scale > 0.5) { // 缩放到目标位.
            if (self.inBottom) { // 从底部
                self.view.transform = CGAffineTransformIdentity;
                self.view.frame = CGRectMake(0, 0, FNScreenW, FNScreenH);
                self.movieView.frame = CGRectMake(0, 0, FNScreenW, FNAVMoviewHeight);
                self.replyImgV.frame = CGRectMake(0, FNAVMoviewHeight, FNScreenW, FNScreenH-FNAVMoviewHeight);
                self.view.layer.anchorPoint = CGPointMake(0, 0);
                self.view.layer.position = CGPointMake(0, 0);
                self.view.transform = CGAffineTransformMakeTranslation(FNScreenW/2*(1-scale), (FNScreenH-playerViewH/2-YJTabBarH)*(1-scale));
                self.view.transform = CGAffineTransformScale(self.view.transform,(1+scale)/2, (1+scale)/2);
                [UIView animateWithDuration:0.3 animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.view.transform = CGAffineTransformScale(self.view.transform, 1, 1);
                    self.replyImgV.alpha = 1;
                } completion:^(BOOL finished) {
                    self.inBottom = NO;
                    self.backBtn.hidden = NO;
                    // 将评论区变回实体
                    self.view.backgroundColor = [UIColor whiteColor];
                    self.replyView.alpha = 1;
                    [self.replyImgV removeFromSuperview];
                }];
            } else { // 从顶部
                self.view.transform = CGAffineTransformIdentity;
                self.view.frame = CGRectMake(FNScreenW/2, FNScreenH-FNAVMoviewHeight/2-YJTabBarH, FNScreenW/2, playerViewH/2);
                self.movieView.frame = CGRectMake(0, 0, FNScreenW/2, FNAVMoviewHeight/2);
                self.replyImgV.frame = CGRectMake(0, FNAVMoviewHeight/2, FNScreenW/2, (FNScreenH-FNAVMoviewHeight)/2);
                self.view.layer.anchorPoint = CGPointMake(0, 0);
                self.view.layer.position = CGPointMake(FNScreenW/2, FNScreenH-playerViewH/2-YJTabBarH);
                self.view.transform = CGAffineTransformMakeTranslation(-FNScreenW/2*(1-scale), -(FNScreenH-playerViewH/2-YJTabBarH)*(1-scale));
                self.view.transform = CGAffineTransformScale(self.view.transform,(1-scale/2)*2, (1-scale/2)*2);
                [UIView animateWithDuration:0.3 animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.view.transform = CGAffineTransformScale(self.view.transform, 1, 1);
                    self.replyImgV.alpha = 0;
                    
                } completion:^(BOOL finished) {
                    self.inBottom = YES;
                    FNAVViewController *avVC = (FNAVViewController *)[self parentViewController];
                    avVC.navigationController.navigationBarHidden = NO;
                    [avVC.screenImgV removeFromSuperview];
                    self.firstOffset = CGPointZero;
                }];
            }
        }else{ // 缩放回原位
            if (self.inBottom) { // 从底部
                [UIView animateWithDuration:0.3 animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.view.transform = CGAffineTransformScale(self.view.transform, 1, 1);
                    self.replyImgV.alpha = 0;
                    self.view.alpha = 1;
                } completion:^(BOOL finished) {
                    self.inBottom = YES;
                    FNAVViewController *avVC = (FNAVViewController *)[self parentViewController];
                    avVC.navigationController.navigationBarHidden = NO;
                    [avVC.screenImgV removeFromSuperview];
                    self.firstOffset = CGPointZero;
                    
                }];
            } else { // 从顶部
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.view.transform = CGAffineTransformScale(self.view.transform, 1, 1);
                    self.replyImgV.alpha = 1;
                } completion:^(BOOL finished) {
                    self.inBottom = NO;
                    // 将评论区变会实体
                    self.replyView.alpha = 1;
                    self.view.backgroundColor = [UIColor whiteColor];
                    [self.replyImgV removeFromSuperview];
                    self.backBtn.hidden = NO;
                }];
            }
            
        }
        
    }
}

- (void)back
{
    if (self.backBlock) {
        self.backBlock();
    }
}

/** 截屏 */
- (UIImage *)drawScreen
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(FNScreenW, YJNavBarMaxY+YJTitlesViewH), NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.navigationController.view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:[NSString stringWithFormat:@"/Users/admin/Desktop/imag.png"]atomically:YES];
    return image;
}


@end
