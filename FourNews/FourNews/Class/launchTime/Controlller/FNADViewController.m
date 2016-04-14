//
//  FNADViewController.m
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#define XMGCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

#import "FNADViewController.h"
#import "FNTabBarController.h"
#import "FNADItem.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

typedef NS_ENUM(NSUInteger, FNScreenType) {
    FNScreenTypeIphone4 = 480,
    FNScreenTypeIphone5 = 568,
    FNScreenTypeIphone6 = 667,
    FNScreenTypeIphone6P = 736
};

@interface FNADViewController ()
@property (weak, nonatomic) IBOutlet UIView *ADView;
@property (weak, nonatomic) IBOutlet UIImageView *launchImageV;
@property (weak, nonatomic) IBOutlet UIButton *adTimeBtn;
@property (nonatomic, strong) FNADItem *item;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, assign) NSInteger timeSeconed;

@end

@implementation FNADViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setADImageV];
    
    self.launchImageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.launchImageV addGestureRecognizer:tap];
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self.ADView addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        
    }
    
    return _imageView;
}

- (void)tap
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:_item.ori_curl]]) {
        [app openURL:[NSURL URLWithString:_item.ori_curl]];
    }
}

- (void)setADImageV
{
    switch ((int)FNScreenH) {
        case FNScreenTypeIphone4:
            self.launchImageV.image = [UIImage imageNamed:@"LaunchImage@2x"];
            break;
        case FNScreenTypeIphone5:
            self.launchImageV.image = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];
            break;
        case FNScreenTypeIphone6:
            self.launchImageV.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
            break;
        case FNScreenTypeIphone6P:
            self.launchImageV.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
            break;
    }
    
    // 发送网络请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = XMGCode2;
    
    [FNNetWorking GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        
        FNADItem *item = [FNADItem mj_objectWithKeyValues:adDict];
        
        if (item.w <= 0) return;
        
        // 展示界面
        CGFloat w = FNScreenW;
        CGFloat h = FNScreenW / item.w * item.h;
        self.imageView.frame = CGRectMake(0, 0, w, h);
        // 加载广告图片
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
        _item = item;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeFlow) userInfo:nil repeats:YES];
    self.timer = timer;
}
// 跳过按钮点击
- (IBAction)adTimeBtnClick:(id)sender {
    
    [self.timer invalidate];
    self.title = nil;
    FNTabBarController *tabBarVC = [[FNTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
}
// 控制跳过时间
- (void)timeFlow
{
    [self.adTimeBtn setTitle:[NSString stringWithFormat:@"跳过 (%lds)",3-self.timeSeconed] forState:UIControlStateNormal];
    
    self.timeSeconed++;
    if (self.timeSeconed == 5) {
        [self.timer invalidate];
        self.title = nil;
        
        FNTabBarController *tabBarVC = [[FNTabBarController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    }
}
@end