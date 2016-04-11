//
//  FNTopicDetailController.m
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicDetailController.h"
#import "FNTopicGetDetailItem.h"
#import <UIImageView+WebCache.h>
#import "FNTopicDetailInsetView.h"
#import "FNTopicTopView.h"
#import "FNTopicDetailHeaderView.h"
#define FNTopicDetailImgH 200
#define FNTopicDetailInsH 136

@interface FNTopicDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *detailItems;

@property (nonatomic, weak) UIImageView *topImgV;

@property (nonatomic, weak) UIView *topV;

@property (nonatomic, weak) UITableView *queAnsTableV;

@property (nonatomic, weak) FNTopicDetailInsetView *insetView;

@property (nonatomic, weak) UILabel *topL;

@end

@implementation FNTopicDetailController
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSMutableArray *)detailItems
{
    if (!_detailItems){
        self.detailItems = [[NSMutableArray alloc] init];
    }
    return _detailItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [FNTopicGetDetailItem getTopicNewsHotDetailWithExpertId:_listItem.expertId :^(NSMutableArray *array) {
        self.detailItems = array;
    }];
    
    [self setTopImgV];

    [self setTopBarV];
    
    [self setQuesAnsTableV];
    
    [self setInsetV];
    
    [self setupTableViewHeaderV];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
#pragma mark - 布局子控件
- (void)setTopImgV
{
    UIImageView *topImgV = [[UIImageView alloc] init];
    topImgV.frame = CGRectMake(0, -YJNavBarH, FNScreenW, FNTopicDetailImgH+40);
    [topImgV sd_setImageWithURL:[NSURL URLWithString:_listItem.picurl] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    [self.view addSubview:topImgV];
    self.topImgV = topImgV;
    [self.view sendSubviewToBack:topImgV];
}
- (void)setTopBarV
{
    FNTopicTopView *topV = [[NSBundle mainBundle] loadNibNamed:@"FNTopicTopView" owner:nil options:0].lastObject;
    topV.backBlock = ^{
        [self backBtnClick];
    };
    topV.frame = CGRectMake(0, YJStateBarH, FNScreenW, YJNavBarH);
    
    UILabel *topL = [[UILabel alloc] init];
    topL.bounds = CGRectMake(0, 0, FNScreenW-80, YJNavBarH);
    topL.center = CGPointMake(FNScreenW/2, YJStateBarH);
    topL.text = _listItem.alias;
    topL.textColor = FNColorAlpha(255, 255, 255, 1);
    topL.font = [UIFont systemFontOfSize:15];
    self.topL = topL;
    [topV addSubview:topL];
    [self.view addSubview:topV];
    self.topV = topV;
}
- (void)setInsetV
{
    FNTopicDetailInsetView *insetView = [FNTopicDetailInsetView TopicDetailInsetViewWith:_listItem];
    self.insetView = insetView;
    insetView.frame = CGRectMake(0, YJNavBarMaxY, FNScreenW, FNTopicDetailInsH);
    [self.view addSubview:insetView];
}
- (void)setQuesAnsTableV
{
    UITableView *queAnsTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, YJNavBarMaxY, FNScreenW, FNScreenH) style:UITableViewStylePlain];
    queAnsTableV.dataSource = self;
    queAnsTableV.delegate = self;
    queAnsTableV.contentInset = UIEdgeInsetsMake(FNTopicDetailInsH, 0, 0, 0);
    queAnsTableV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:queAnsTableV];
    self.queAnsTableV = queAnsTableV;
    [self.view bringSubviewToFront:queAnsTableV];
}

#pragma mark - 设置headerView
- (void)setupTableViewHeaderV
{
    FNTopicDetailHeaderView *headerV = [FNTopicDetailHeaderView topicDetailHeaderViewWithListItem:_listItem];
    self.queAnsTableV.tableHeaderView = headerV;
}

#pragma mark - tableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"1111";
    return cell;
}

#pragma mark - Table view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算insetView的偏移位置
    if (scrollView.contentOffset.y>-FNTopicDetailInsH) {
        self.insetView.frame = CGRectMake(0, YJNavBarMaxY-FNTopicDetailInsH-scrollView.contentOffset.y, FNScreenW, 136);
        if (scrollView.contentOffset.y>0) return;
        // 顶部图片下移
        self.topImgV.frame = CGRectMake(0, -40+(scrollView.contentOffset.y+FNTopicDetailInsH)/136*40, FNScreenW, self.topImgV.frame.size.height);
    }
    // 改变insetView的透明度
    self.insetView.descL.alpha = 1 - (scrollView.contentOffset.y+FNTopicDetailInsH)/80.0;
    self.insetView.alpha = 1 - (scrollView.contentOffset.y+FNTopicDetailInsH)/100.0;
    
    // 改变顶部文字的透明度
    self.topL.alpha = (scrollView.contentOffset.y+FNTopicDetailInsH)/100;
    
}

#pragma mark - 监听返回按钮点击

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
