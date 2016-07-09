//
//  FNTabBarController.m
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTabBarController.h"
#import "FNNewsViewController.h"
#import "FNReadViewController.h"
#import "FNAVViewController.h"
#import "FNTopicViewController.h"
#import "FNMeController.h"
#import "FNNavigationController.h"

@interface FNTabBarController () <UITabBarControllerDelegate>

@property (nonatomic, strong) FNNewsViewController *newsVC;
@property (nonatomic, strong) FNReadViewController *readVC;
@property (nonatomic, strong) FNAVViewController *avVC;
@property (nonatomic, strong) FNTopicViewController *topicVC;
@property (nonatomic, strong) FNMeController *meVC;
@property (nonatomic, assign) BOOL isReady;



@property (nonatomic, strong) UITabBarItem *selectedItem;

@end


@implementation FNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加自控制器
    [self setChildControllers];
    // 给初值
    self.selectedItem = self.childViewControllers[0].tabBarItem;
    // 设置tabBar按钮的选中颜色
    [self.tabBar setTintColor:[UIColor redColor]];
    // isReady初始值为yes
    _isReady = YES;
    // 准备好刷新的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isReadyChange) name:FNRefreshReady object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 广告界面与首页交接时的动画
    [self startAppearAnimation];
}
// 创建设置子控制器，并抽取方法统一配置
- (void)setChildControllers
{
    FNNewsViewController *newsVC = [[FNNewsViewController alloc] init];
    self.newsVC = newsVC;
    [self setupChildController:self.newsVC title:@"新闻" image:@"tabbar_icon_news_normal" selectedImage:@"tabbar_icon_news_highlight"];
    
    FNReadViewController *readVC = [[FNReadViewController alloc] init];
    self.readVC = readVC;
    [self setupChildController:self.readVC title:@"阅读" image:@"tabbar_icon_reader_normal" selectedImage:@"tabbar_icon_reader_highlight"];
    
    FNAVViewController *avVC = [[FNAVViewController alloc] init];
    self.avVC = avVC;
    [self setupChildController:self.avVC title:@"视听" image:@"tabbar_icon_media_normal" selectedImage:@"tabbar_icon_media_highlight"];
    
    FNTopicViewController *topicVC = [[FNTopicViewController alloc] init];
    self.topicVC = topicVC;
    [self setupChildController:self.topicVC title:@"话题" image:@"tabbar_icon_found_normal" selectedImage:@"tabbar_icon_found_highlight"];
    
    FNMeController *meVC = [[UIStoryboard storyboardWithName:@"FNMeController" bundle:nil] instantiateInitialViewController];
    self.meVC = meVC;
    [self setupChildController:self.meVC title:@"我" image:@"tabbar_icon_me_normal" selectedImage:@"tabbar_icon_me_highlight"];
}
// 抽取的方法，并包装上了导航控制器
- (void)setupChildController:(UIViewController *)controller title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectesImage
{
    FNNavigationController *nav = [[FNNavigationController alloc] initWithRootViewController:controller];
    controller.title = title;
    nav.title = title;
    [controller.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    controller.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    nav.fullScreenPopGestureEnabled = YES;
    nav.tabBarItem.image = [UIImage imageWithOriginImage:[UIImage imageNamed:image]];
    nav.tabBarItem.selectedImage = [UIImage imageWithOriginImage:[UIImage imageNamed:selectesImage]];
    
    [self addChildViewController:nav];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (self.selectedItem == item && _isReady == YES) {
        // 发布tabBarButton被点击的通知
        // 这个通知的回调是在点击它的时候直接刷新对应模块的数据
        [[NSNotificationCenter defaultCenter] postNotificationName:FNTabBarButtonRepeatClickNotification object:nil];
        // 未准备好再次刷新
        _isReady = NO;
    }
    self.selectedItem = item;
}

// 交接动画
- (void)startAppearAnimation
{
    [UIView animateWithDuration:1.0 animations:^{
        self.coverImgView.alpha = 0;
        self.coverImgView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [self.coverImgView removeFromSuperview];
    }];
}

- (void)isReadyChange
{
    _isReady = YES;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
