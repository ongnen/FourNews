//
//  FNNewsViewController.m
//  FourNews
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsViewController.h"
#import "FNNewsListController.h"
#import <MJExtension.h>
#import "FNNewsPortItem.h"
#import "FNNewsSearchController.h"

@interface FNNewsViewController ()

@property (nonatomic,strong) NSArray<FNNewsPortItem *> *dataPortArray;

@end

@implementation FNNewsViewController

- (NSArray *)dataPortArray
{
    if (!_dataPortArray) {
        _dataPortArray = [FNNewsPortItem mj_objectArrayWithFilename:@"NewsURLs.plist"];
    }
    return _dataPortArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聚天下,闻四方";
    // 添加所有子控件
    [self setAllChildController];
    
    // 调用父类方法进行布局设置
    [self setAllPrepare];
    
    // 导航条按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginImage:[UIImage imageNamed:@"search_icon"]] style:0 target:self action:@selector(searchBtnClick)];
    
    // 取出历史浏览记录
    [self setHistorySkim];
}

#pragma mark - 取出历史浏览记录
- (void)setHistorySkim
{
    NSMutableArray *historySkim = [FNUserDefaults objectWithKey:@"historySkim"];
    if (historySkim == nil) {
        historySkim = [NSMutableArray array];
        [FNUserDefaults setObject:historySkim forKey:@"historySkim"];
    }
}

- (void)setAllChildController
{
    FNNewsListController *headVC = [[FNNewsListController alloc] init];
    headVC.pgmid = self.dataPortArray[0].urlString;
    headVC.title = @"头条";
    [self addChildViewController:headVC];
    
    FNNewsListController *NBAVC = [[FNNewsListController alloc] init];
    NBAVC.pgmid = self.dataPortArray[1].urlString;
    NBAVC.title = @"NBA";
    [self addChildViewController:NBAVC];

    FNNewsListController *phoneVC = [[FNNewsListController alloc] init];
    phoneVC.pgmid = self.dataPortArray[2].urlString;
    phoneVC.title = @"手机";
    [self addChildViewController:phoneVC];
    
    FNNewsListController *moveVC = [[FNNewsListController alloc] init];
    moveVC.pgmid = self.dataPortArray[3].urlString;
    moveVC.title = @"移动互联";
    [self addChildViewController:moveVC];
    
    FNNewsListController *recVC = [[FNNewsListController alloc] init];
    recVC.pgmid = self.dataPortArray[4].urlString;
    recVC.title = @"娱乐";
    [self addChildViewController:recVC];
    
    FNNewsListController *fashionVC = [[FNNewsListController alloc] init];
    fashionVC.pgmid = self.dataPortArray[5].urlString;
    fashionVC.title = @"时尚";
    [self addChildViewController:fashionVC];
    
    FNNewsListController *movieVC = [[FNNewsListController alloc] init];
    movieVC.pgmid = self.dataPortArray[6].urlString;
    movieVC.title = @"电影";
    [self addChildViewController:movieVC];
    
    FNNewsListController *scienceVC = [[FNNewsListController alloc] init];
    scienceVC.pgmid = self.dataPortArray[7].urlString;
    scienceVC.title = @"科技";
    [self addChildViewController:scienceVC];
}

- (void)searchBtnClick
{
    FNNewsSearchController *searchVC = [[FNNewsSearchController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

@end
