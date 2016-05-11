//
//  FNNavigationController.m
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
// _UINavigationInteractiveTransition

#import "FNNavigationController.h"
#import "FNNewsPhotoSetController.h"

@interface FNNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation FNNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 实现全屏滑动的核心方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
}
// 重写push方法进行某些设置
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 1.在非根控制器下隐藏tabBar
    // 2.在非根控制器下设置全局统一样式的返回按钮
    if (self.childViewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginImage:[UIImage imageNamed:@"navigationbar_back"]] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
       
    }
    // 3.在图集展示控制器下导航栏隐藏
    if ([viewController isKindOfClass:[FNNewsPhotoSetController class]]) {
        self.navigationBarHidden = YES;
    } else {
        self.navigationBarHidden = NO;
    }
    // 4.实现父类方法
    [super pushViewController:viewController animated:animated];
}
// 返回的方法
- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
