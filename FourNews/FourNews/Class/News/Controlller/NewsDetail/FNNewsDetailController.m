//
//  FNNewsDetailController.m
//  FourNews
//
//  Created by admin on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsDetailController.h"
#import "FNNewsDetailContView.h"
#import "MBProgressHUD+MJ.h"
#import "FNNewsGetReply.h"
#import "FNNewsRelativeItem.h"
#import "FNNewsGetDetailNews.h"
#import "FNNewsReplyController.h"
#import "FNNewsReplyButton.h"
#import "FNNewsGetHotWordsList.h"
#import "FNNewsSearchListController.h"
#import "FNNewsGetSearchNews.h"

#import <MJExtension.h>


@interface FNNewsDetailController ()

@property (nonatomic, strong) FNNewsDetailContView *contView;

@end

@implementation FNNewsDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setBottomImgV];
    
}



#pragma mark - 记录浏览历史
- (void)saveHistorySkim
{
    // 从沙盒中取出的数组默认是不可变的 用mutableCopy拷贝一份
    NSMutableArray *historySkim = [[FNUserDefaults objectWithKey:@"historySkim"] mutableCopy];
    id item = [NSKeyedUnarchiver unarchiveObjectWithData:historySkim.lastObject];
    // 与上次是访问相同新闻则不添加到历史
    if (![[item title] isEqualToString:_listItem?_listItem.title:_detailItem.title]) {
        if (_listItem) {
            NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:_listItem];
            [historySkim addObject:listData];
        } else if (_detailItem){
            NSData *detailItem = [NSKeyedArchiver archivedDataWithRootObject:_detailItem];
            [historySkim addObject:detailItem];
        }
    }
    
    [FNUserDefaults setObject:historySkim forKey:@"historySkim"];
}



/*
 创建主详情View以及其他次View
 */
- (void)setDetailItem:(FNNewsDetailItem *)detailItem
{
    
    if (detailItem.ptime == nil) {
        [MBProgressHUD showError:@"暂无数据"];
        return;
    }
    _detailItem = detailItem;
    [self saveHistorySkim];
    // 创建主View
    [self setContentScroView];
    __weak typeof(self) weakSelf = self;
    self.contView.relativeBlock = ^(NSString *docid){
        [weakSelf relativeClickWithDocid:docid];
    };
    
    self.contView.replyBlock = ^{
        [weakSelf replyClick];
    };
    // 当数据返回后设置导航栏评论按钮
    [self setTopReplyBtn];
}
- (void)setContentScroView
{
    FNNewsDetailContView *contView = [[FNNewsDetailContView alloc] init];
    contView.lastKeyWordBtnClick = ^(NSString *keyWord){
        [self keyWordBtnClick:keyWord];
    };
    contView.frame = CGRectMake(0, 64, FNScreenW, FNScreenH-64-49);
    [self.view addSubview:contView];
    contView.detailItem = _detailItem;
    contView.contentSize = CGSizeMake(FNScreenW, contView.totalHeight);
    contView.backgroundColor = FNColor(245, 245, 245);
    self.contView = contView;
    
    // 创建内部的replyView
    // 创建内部的relativeView
}

- (void)relativeClickWithDocid:(NSString *)docid
{
    // 1.跳转
    FNNewsDetailController *detailVC = [[FNNewsDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    // 传数据
    [FNNewsGetDetailNews getNewsDetailWithDocid:docid :^(FNNewsDetailItem *item) {
        [FNNewsGetReply hotReplyWithDetailItem:item :^(NSArray *array) {
            item.replys = array;
            detailVC.detailItem = item;
            
        }];
        
    }];
}

- (void)replyClick
{
    // 1.跳转
    FNNewsReplyController *replyVC = [[FNNewsReplyController alloc] init];
    replyVC.docid = _detailItem.docid;
    replyVC.boardid = _detailItem.replyBoard;
    [self.navigationController pushViewController:replyVC animated:YES];
}


- (void)setBottomImgV
{
    
    UIImageView *botomImgV = [[UIImageView alloc] init];
    botomImgV.image = [UIImage imageNamed:@"detailBottomBackGround"];
    botomImgV.frame = CGRectMake(0, self.view.height-FNBottomBarHeight, FNScreenW, FNBottomBarHeight);
    [self.view addSubview:botomImgV];
}

- (void)setTopReplyBtn
{
    FNNewsReplyButton *replyBtn = [[FNNewsReplyButton alloc] init];
    NSString *replyStr = [NSString stringWithFormat:@"%ld评论",_detailItem.replyCount];
    CGSize replyBtnSize = [replyStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [replyBtn addTarget:self action:@selector(replyClick) forControlEvents:UIControlEventTouchUpInside];
    replyBtn.bounds = (CGRect){0, 0,replyBtnSize.width+10,30};
    [replyBtn setTitle:replyStr forState:UIControlStateNormal];
    [replyBtn setImage:[UIImage resizableImage:@"contentview_commentbacky"] forState:UIControlStateNormal];
    replyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    replyBtn.contentEdgeInsets = UIEdgeInsetsMake( 0, 20, 0, -20);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:replyBtn];
}

- (void)keyWordBtnClick:(NSString *)keyWord
{
    FNNewsSearchListController *searchListVC = [[FNNewsSearchListController alloc] init];
    [self.navigationController pushViewController:searchListVC animated:YES];
    
    [FNNewsGetSearchNews getSearchNewsWithWord:keyWord :^(NSArray *array) {
        searchListVC.searchItems = array;;
    }];
}

@end
