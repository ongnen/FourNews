//
//  FNMeController.m
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#define FNSquareMargin 1
#define FNSquareConl 4
#define FNCollecWH (FNScreenW-FNSquareConl+1)/FNSquareConl

#import "FNMeController.h"

#import "UIBarButtonItem+YJ.h"
#import "FNMeGetSquareItem.h"
#import "FNMeSquareViewCell.h"
#import "FNWKWebController.h"
#import <SafariServices/SafariServices.h>
#import "FNMeSettingController.h"
#import "FNMeSquareItem.h"
#import "YJGridView.h"

@interface FNMeController () <UICollectionViewDataSource,UICollectionViewDelegate,SFSafariViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray<FNMeSquareItem *> *squareArray;

@property (nonatomic, weak) UICollectionView *collectionV;

@property (nonatomic, strong) NSMutableArray<YJGridButtonitem *> *itemArray;


@end

@implementation FNMeController



static NSString *const ID = @"cell";
- (NSMutableArray *)squareArray
{
    if (!_squareArray){
        self.squareArray = [[NSMutableArray alloc] init];
    }
    return _squareArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = FNCommonColor;
    // 设置
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:0 target:self action:@selector(setBtnClick)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    
    [FNMeGetSquareItem squareItem:^(NSArray *array) {
        self.squareArray = (NSMutableArray *)array;
        
        // 设置footView为collectionView
        [self setupFooterView];
        
//        // 补齐空位
//        NSInteger addCount = 4- ((array.count-1)%4+1);
//        for (int i = 0; i<addCount; i++) {
//            [self.squareArray addObject:[[FNMeSquareItem alloc] init]];
//        }
//        // 在这里拿到真正的collectionV高度
//        self.collectionV.frame = CGRectMake(0, 0, 0, ((self.squareArray.count-1)/4+1)*FNCollecWH);
        // 刷新内容
        [self.tableView reloadData];
    }];
    
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    
    // 减少额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
}
// 设置tableView.footView为自己定义的collectionView
- (void)setupFooterView
{
    // 创建设置好collectionView
//    UICollectionViewFlowLayout *flowLy = [[UICollectionViewFlowLayout alloc] init];
//    flowLy.itemSize = CGSizeMake(FNCollecWH, FNCollecWH);
//    flowLy.minimumInteritemSpacing = 0;
//    flowLy.minimumLineSpacing = 1;
//    
//    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLy];
//    collectionV.backgroundColor = FNColor(215, 215, 215);
//    [collectionV registerNib:[UINib nibWithNibName:@"FNMeSquareViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
//    collectionV.dataSource = self;
//    collectionV.delegate = self;
//    collectionV.scrollEnabled = NO;
//    _collectionV = collectionV;
    
    NSMutableArray *itemArray = [NSMutableArray array];
    
    for (int i = 0; i<self.squareArray.count; i++) {
        YJGridButtonitem *item = [[YJGridButtonitem alloc] init];
        FNMeSquareItem *squareItem = self.squareArray[i];
        item.image = squareItem.icon;
        item.desc = squareItem.name;
        item.url = squareItem.url;
        item.index = i;
        [itemArray addObject:item];
    }
    self.itemArray = itemArray;
    YJGridView *gridView = [YJGridView gridViewWithlist:itemArray];
    CGFloat gridX = 0;
    CGFloat gridY = 0;
    CGFloat gridW = FNScreenW;
    CGFloat gridH = (itemArray.count / 4 + 1) * FNScreenW/4;
    gridView.frame = CGRectMake(gridX, gridY, gridW, gridH);
    gridView.listBtnClickBlock = ^(YJGridItemListButton *btn){
        [self btnClick:btn];
    };
    // 关键代码
    self.tableView.tableFooterView = gridView;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FNMeSquareViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.squareArray[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FNWKWebController *webVC = [[FNWKWebController alloc] init];
    webVC.url = self.squareArray[indexPath.row].url;
    [self.navigationController pushViewController:webVC animated:YES];
    
    
    // 用SFSafariViewController实现打开webView
    /*
     if (![self.squareArray[indexPath.row].url containsString:@"http"]) return;
     
     SFSafariViewController *sfVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:self.squareArray[indexPath.row].url]];
     sfVC.delegate = self;
     // 设置SFSafari为madel弹出模式，它会自动设置点击Done为dismiss
     [self presentViewController:sfVC animated:YES completion:nil];
     */
}

- (void)btnClick:(YJGridItemListButton *)btn
{
    FNWKWebController *webVC = [[FNWKWebController alloc] init];
    webVC.url = btn.url;
    [self.navigationController pushViewController:webVC animated:YES];
}

// 跳转到设置界面
- (void)setBtnClick
{
    FNMeSettingController *settingVC = [[FNMeSettingController alloc] init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
}


@end
