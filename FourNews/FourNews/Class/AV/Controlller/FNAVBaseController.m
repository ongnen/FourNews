//
//  FNAVBaseController.m
//  FourNews
//
//  Created by admin on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//
#define YJScreenW [UIScreen mainScreen].bounds.size.width
#define YJScreenH [UIScreen mainScreen].bounds.size.height
#define YJConH YJScreenH - 64 - self.titleScrollView..height - 49
#import "FNAVBaseController.h"
#import "FNTabBarController.h"
#import "FNAVListController.h"


@interface FNAVBaseController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *titleBtnArray;

@property (nonatomic, assign) BOOL isSet;


@end

@implementation FNAVBaseController

- (NSMutableArray *)titleBtnArray
{
    if (!_titleBtnArray){
        self.titleBtnArray = [[NSMutableArray alloc] init];
    }
    return _titleBtnArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setAllPrepare
{
    [self setContentScrollView];
    [self setTitleScrollView];
    [self setTitleScrollViewBtn];
    [self titleViewBtnClick:self.titleBtnArray[0]];
}
#pragma mark - 设置标题scrollView
- (void)setTitleScrollView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, YJScreenW, 35)];
    titleScrollView.backgroundColor = FNColorAlpha(255, 255, 255, 0);
    titleScrollView.backgroundColor = [UIColor whiteColor];
    
    CGFloat W = self.childViewControllers.count * YJScreenW / 4;
    titleScrollView.contentSize = CGSizeMake(W, 0);
    titleScrollView.showsHorizontalScrollIndicator = NO;
    titleScrollView.showsVerticalScrollIndicator = NO;
    titleScrollView.scrollsToTop = NO;
    [self.view addSubview:titleScrollView];
    self.titleScrollView = titleScrollView;
}
#pragma mark - 设置标题按钮
- (void)setTitleScrollViewBtn
{
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *VC = self.childViewControllers[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.titleBtnArray addObject:btn];
        CGFloat X = YJScreenW/4 * i;
        btn.frame = CGRectMake(X, 0, YJScreenW/4, 35);
        btn.tag = i;
        if (btn.tag == 0) {
            self.selectedBtn = btn;
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [btn setTitle:VC.title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
    }
}
#pragma mark - 监听标题按钮点击
- (void)titleViewBtnClick:(UIButton *)btn
{
    // 发布通知
    if (self.selectedBtn == btn) {
        // object = nil 匿名通知
        [[NSNotificationCenter defaultCenter] postNotificationName:FNTitleButtonRepeatClickNotification object:nil];
    }
    self.selectedBtn.transform = CGAffineTransformIdentity;
    self.selectedBtn.selected = NO;
    [self.selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.selected = YES;
    self.selectedBtn = btn;
    [self.selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.contentScrollView.contentOffset = CGPointMake(YJScreenW * btn.tag, 0);
    
    self.selectedBtn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    CGFloat offSetX = 0;
    if (btn.center.x < YJScreenW/2) {
        offSetX = 0;
    }else if ((self.titleScrollView.contentSize.width - btn.center.x) < YJScreenW/2) {
        offSetX = self.titleScrollView.contentSize.width - YJScreenW;
    } else {
        offSetX = btn.center.x - YJScreenW/2;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    
    [self showTargetViewWithIndex:btn.tag];
}
#pragma mark - 设置contentScrollView
- (void)setContentScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.delegate = self;
    contentScrollView.frame = CGRectMake(0, 0, FNScreenW , FNScreenH);
    contentScrollView.backgroundColor = [UIColor whiteColor];
    
    contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * YJScreenW, 0);
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.scrollsToTop = NO;
    
    [self.view addSubview:contentScrollView];

    
    
    self.contentScrollView = contentScrollView;
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x<0 | scrollView.contentOffset.x>=(self.titleBtnArray.count-1)*YJScreenW) return;
    
    NSInteger index = scrollView.contentOffset.x / YJScreenW;
    
    UIButton *leftbtnBtn = self.titleBtnArray[index];
    UIButton *rightBtn = self.titleBtnArray[index+1];
    
    CGFloat rightScale = (scrollView.contentOffset.x - index*YJScreenW)/YJScreenW;
    CGFloat leftScale = 1 - rightScale;
    
    rightBtn.transform = CGAffineTransformMakeScale(rightScale*0.3+1, rightScale*0.3+1);
    leftbtnBtn.transform = CGAffineTransformMakeScale(leftScale*0.3+1, leftScale*0.3+1);
    
    [rightBtn setTitleColor:[UIColor colorWithRed:rightScale green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    [leftbtnBtn setTitleColor:[UIColor colorWithRed:leftScale green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    
}
#pragma mark - 展示点击的目标View
- (void)showTargetViewWithIndex:(NSInteger)index
{
    FNAVListController *tableVC = (FNAVListController*)self.childViewControllers[index];
    // 如果已经添加了View,不做重复操作
    if (!tableVC.tableView.window) {
        tableVC.view.tag = index;
        [self.contentScrollView addSubview:tableVC.view];
        tableVC.view.frame = CGRectMake(FNScreenW * index, 0, FNScreenW, FNScreenH);
        tableVC.tableView.contentInset = UIEdgeInsetsMake(YJNavBarMaxY+YJTitlesViewH, 0, YJTabBarH, 0);
    }
    
    // 对左右两个新闻界面进行缓存
    if (index == 0) {
        UITableViewController *rightTableVC = (UITableViewController*)self.childViewControllers[index+1];
        if (rightTableVC.tableView.window) return;
        [self.contentScrollView addSubview:rightTableVC.view];
        rightTableVC.view.frame = CGRectMake(FNScreenW * (index+1), 0, FNScreenW, FNScreenH);
        rightTableVC.tableView.contentInset = UIEdgeInsetsMake(YJNavBarMaxY+YJTitlesViewH, 0, YJTabBarH, 0);
    } else if (index == self.childViewControllers.count-1) {
        UITableViewController *leftTableVC = (UITableViewController*)self.childViewControllers[index-1];
        if (leftTableVC.tableView.window) return;
        [self.contentScrollView addSubview:leftTableVC.view];
        leftTableVC.view.frame = CGRectMake(FNScreenW * (index-1), 0, FNScreenW, FNScreenH);
        leftTableVC.tableView.contentInset = UIEdgeInsetsMake(YJNavBarMaxY+YJTitlesViewH, 0, YJTabBarH, 0);
    } else {
        UITableViewController *rightTableVC = (UITableViewController*)self.childViewControllers[index+1];
        if (!rightTableVC.tableView.window) {
            [self.contentScrollView addSubview:rightTableVC.view];
            rightTableVC.view.frame = CGRectMake(FNScreenW * (index+1), 0, FNScreenW, FNScreenH);
            rightTableVC.tableView.contentInset = UIEdgeInsetsMake(YJNavBarMaxY+YJTitlesViewH, 0, YJTabBarH, 0);
        }
        UITableViewController *leftTableVC = (UITableViewController*)self.childViewControllers[index-1];
        if (!leftTableVC.tableView.window) {
            [self.contentScrollView addSubview:leftTableVC.view];
            leftTableVC.view.frame = CGRectMake(FNScreenW * (index-1), 0, FNScreenW, FNScreenH);
            leftTableVC.tableView.contentInset = UIEdgeInsetsMake(YJNavBarMaxY+YJTitlesViewH, 0, YJTabBarH, 0);
        }
    }
    
    // 保持最多5个控制器的View存在
    NSInteger tableVCIndex = 0;
    for (UITableViewController *tableVC in self.childViewControllers) {
        if (fabs((double)(tableVCIndex-index)) > 2) {
            [tableVC.view removeFromSuperview];
        }
        tableVCIndex++;
    }
    
    for (int i = 0;i < self.childViewControllers.count ;i++) {
        UITableViewController *tableVC = self.childViewControllers[i];
        tableVC.tableView.scrollsToTop = (i == index);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / YJScreenW;
    
    
    UIButton *btn = self.titleBtnArray[index];
    // 如果滑动减速后的页面还是当前页面，就不调用下面的方法
    if (self.selectedBtn == btn) return;
    
    [self titleViewBtnClick:btn];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AVListEndDecelerating object:nil];
}
@end

