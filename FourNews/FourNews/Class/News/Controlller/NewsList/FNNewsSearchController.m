//
//  FNNewsSearchController.m
//  FourNews
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsSearchController.h"
#import "FNNewsHistoryView.h"
#import "FNNewsHotWordsListView.h"
#import "FNNewsGetHotWordsList.h"
#import "FNNewsPhotoSetController.h"
#import "FNNewsDetailController.h"
#import "FNNewsGetDetailNews.h"
#import "FNNewsGetReply.h"
#import "FNNewsGetSearchNews.h"
#import "FNNewsSearchListController.h"
#import "FNNewsHistorySkimController.h"

@interface FNNewsSearchController () <UISearchBarDelegate>

@property (nonatomic, weak) UIView *historyView;

@property (nonatomic, strong) NSArray *hotWords;

@property (nonatomic, strong) NSArray *searchNews;

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation FNNewsSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [FNNewsGetHotWordsList getHotWordList:^(NSArray *array) {
        self.hotWords = array;
        [self setHotWordView];
    }];
    
    [self setTopViews];
    
    [self setHistoryV];
    
}

- (void)cancelBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTopViews
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    self.searchBar = searchBar;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(cancelBtnClick)];
    self.navigationController.navigationBar.tintColor = FNColor(150, 150, 150);
}
#pragma mark - 设置历史浏览界面
- (void)setHistoryV
{
    FNNewsHistoryView *historyView = [[NSBundle mainBundle] loadNibNamed:@"FNNewsHistoryView" owner:nil options:nil].lastObject;
    historyView.historyBlock = ^(id item){
        [self historySkimBtnClickWithListItem:item];
    };
    historyView.moreBlock = ^{
        [self historySkimBtnClick];
    };
    historyView.frame = CGRectMake(0, FNTopBarHeight+50, FNScreenW, 140);
    [self.view addSubview:historyView];
    self.historyView = historyView;
}
#pragma mark - 查看历史浏览
- (void)historySkimBtnClickWithListItem:(id)item
{
    if ([item isKindOfClass:[FNNewsListItem class]]) {
        FNNewsListItem *listItem = (FNNewsListItem *)item;
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
    } else {
        FNNewsDetailItem *detailItem = (FNNewsDetailItem *)item;
        FNNewsDetailController *detailVC = [[FNNewsDetailController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
        // 传数据
        [FNNewsGetDetailNews getNewsDetailWithDocid:detailItem.docid :^(FNNewsDetailItem *item) {
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
#pragma mark - 设置热词界面
- (void)setHotWordView
{
    FNNewsHotWordsListView *hotWordListView = [[NSBundle mainBundle] loadNibNamed:@"FNNewsHotWordsListView" owner:nil options:nil].lastObject;
    hotWordListView.hotWordBlock = ^(NSString *word){
        [self hotWordSearchWithWord:word];
    };
    hotWordListView.hotWords = self.hotWords;
    hotWordListView.frame = CGRectMake(0, CGRectGetMaxY(self.historyView.frame), FNScreenW, FNScreenH-CGRectGetMaxY(self.historyView.frame));
    [self.view addSubview:hotWordListView];
}
#pragma mark - 热词点击
- (void)hotWordSearchWithWord:(NSString *)word
{
    FNNewsSearchListController *searchListVC = [[FNNewsSearchListController alloc] init];
    [self.navigationController pushViewController:searchListVC animated:YES];
    
    [FNNewsGetSearchNews getSearchNewsWithWord:word :^(NSArray *array) {
        searchListVC.searchItems = array;;
    }];
}

- (void)historySkimBtnClick
{
    FNNewsHistorySkimController *historySkimVC = [[FNNewsHistorySkimController alloc] init];
    [self.navigationController pushViewController:historySkimVC animated:YES];
}


#pragma mark - UITextFieldDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self hotWordSearchWithWord:searchBar.text];
}

@end
