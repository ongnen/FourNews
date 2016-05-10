//
//  FNMeSettingController.m
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNMeSettingController.h"
#import "FNFileManager.h"
#import "MBProgressHUD+MJ.h"
#import "YJWaveAnimationInTool.h"
#import "FNSettingMostCacheController.h"

@interface FNMeSettingController ()

@property (nonatomic, weak) UIView *backV;

@property (nonatomic, weak) UILabel *persentL;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat cacheContent;

@property (nonatomic, assign) CGFloat realPersent;

@end

@implementation FNMeSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置分隔线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    YJWaveAnimationTool *waveToll = [YJWaveAnimationTool shareWaveAnimationTool];
    self.persentL = waveToll.persentL;
    self.persentL.textAlignment = NSTextAlignmentCenter;
    self.persentL.textColor = [UIColor orangeColor];
    self.persentL.font = [UIFont fontWithName:@"TransformersSolidNormal" size:30];
    
    [self addGroup0];
    
    [self setTableViewHeader];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 刷新最大缓存数
    if ([FNUserDefaults integerForKey:@"mostCache"] == 0) return;
    YJSettingGroupItem *group = self.groupArray[0];
    YJSettingCellArrowItem *item2 = group.items[2];
    YJSettingCellBaseItem *item0 = group.items[0];
    item2.detailTitle = [NSString stringWithFormat:@"%ldM",[FNUserDefaults integerForKey:@"mostCache"]];
    self.realPersent = [item0.detailTitle floatValue]/[item2.detailTitle floatValue];
    if ([item2.detailTitle isEqualToString:@"1024M"]) {
        item2.detailTitle = @"1G";
    }
    
    [[YJWaveAnimationTool shareWaveAnimationTool] removeAnimation];
    
    [self setTableViewHeader];
    [self.tableView reloadData];
    
}

- (void)addGroup0 {
    
    YJSettingGroupItem *group1 = [[YJSettingGroupItem alloc] init];
    YJSettingCellBaseItem *item1 = [YJSettingCellBaseItem settingRowItemWithTitle:@"清理缓存" image:nil];
    // 计算缓存大小
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
   item1.detailTitle = [NSString stringWithFormat:@"%.1lfM",[FNFileManager getSizeWithFilePath:cache]/1000000.0];
    // 模拟缓存大小
//    item1.detailTitle = @"80.0M";
    self.persentL.text = item1.detailTitle;
    self.cacheContent = [self.persentL.text floatValue];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(YJSettingCellBaseItem *) weakItem1 = item1;
    item1.option = ^{
        // 判断是否刚刚清除过
        if ([weakSelf.persentL.text isEqualToString:@"0.0M"]) return ;
        
        // 清除缓存
        NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [FNFileManager clearDiskWithFilePath:cache];
        
        // 重新给模型赋值
        weakItem1.detailTitle = [NSString stringWithFormat:@"%.1lfM",[FNFileManager getSizeWithFilePath:cache]/1000000.0];
        // 开始清除动画
        [weakSelf clear];
    };
    // 历史记录模型
    YJSettingCellBaseItem *item2 = [YJSettingCellBaseItem settingRowItemWithTitle:@"清除历史记录" image:nil];
    NSMutableArray *historySkim = [[FNUserDefaults objectWithKey:@"historySkim"] mutableCopy];
    item2.detailTitle = [NSString stringWithFormat:@"%ld条",historySkim.count];
    __weak typeof(YJSettingCellBaseItem *) weakItem2 = item2;
    item2.option = ^{
        // 清除历史记录
        NSMutableArray *historySkim = [NSMutableArray array];
        [FNUserDefaults setObject:historySkim forKey:@"historySkim"];
        // 重新给模型赋值
        NSMutableArray *historySkim1 = [[FNUserDefaults objectWithKey:@"historySkim"] mutableCopy];
        weakItem2.detailTitle = [NSString stringWithFormat:@"%ld条",historySkim1.count];
        // 刷新
        [weakSelf.tableView reloadData];
    };
    
    // 最大缓存数模型
    YJSettingCellArrowItem *item3 = [YJSettingCellArrowItem settingRowItemWithTitle:@"设置最大缓存数" image:nil];
    
    if ([FNUserDefaults integerForKey:@"mostCache"] == 0) {
        item3.detailTitle = @"100M";
    } else {
        item3.detailTitle = [NSString stringWithFormat:@"%ldM",[FNUserDefaults integerForKey:@"mostCache"]];
        if ([item3.detailTitle isEqualToString:@"1024M"]) {
            item3.detailTitle = @"1G";
        }
    }
    item3.desClass = [FNSettingMostCacheController class];
    
    self.realPersent = [item1.detailTitle floatValue]/[([item3.detailTitle isEqualToString:@"1G"]? @"1024":item3.detailTitle) floatValue];
    
    
    group1.items = @[item1,item2,item3];
    
    [self.groupArray addObject:group1];
}

#pragma mark - 设置headerView
- (void)setTableViewHeader{
    UIView *tableHeader = [[UIView alloc] init];
    tableHeader.backgroundColor = [UIColor colorWithRed:68/255.0 green:190/255.0 blue:167/255.0 alpha:1];
    tableHeader.frame = CGRectMake(0, 0, FNScreenW, 300);
    self.tableView.tableHeaderView = tableHeader;
    
    YJWaveAnimationTool *waveToll = [YJWaveAnimationTool shareWaveAnimationTool];
    waveToll.inView = tableHeader;
    if (self.realPersent <= 0.1) {
        self.realPersent = 0.1;
    }

    // 水位上升动画
    [waveToll raiseAnimationWithDuration:2.0 toPersent:self.realPersent target:nil action:nil completion:nil];
    // 底部波浪动画
    [tableHeader addWaveAnimationWithWaveHeight:50 alpha:0.3];
    
    UIView *backV = [[UIView alloc] init];
    backV.backgroundColor = [UIColor colorWithRed:68/255.0 green:190/255.0 blue:167/255.0 alpha:1];
    backV.frame = CGRectMake(0, -64, FNScreenW, 64);
    [self.tableView addSubview:backV];
    self.backV = backV;
}


#pragma mark - 文字清除动画
- (void)clear {
    YJWaveAnimationTool *waveToll = [YJWaveAnimationTool shareWaveAnimationTool];
    [waveToll fallAnimationWithDuration:1.0 target:nil action:nil completion:^{
        [self.tableView reloadData];
    }];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0/80.0 target:self selector:@selector(changePersent) userInfo:nil repeats:YES];
    self.timer = timer;
}
- (void)changePersent{
    self.persentL.text = [NSString stringWithFormat:@"%0.1lfM",(60-self.index)/60.0*self.cacheContent];
    self.index++;
    if (self.index == 61) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - scrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.backV.frame = CGRectMake(0, scrollView.contentOffset.y, FNScreenW, fabs(scrollView.contentOffset.y));
}


@end
