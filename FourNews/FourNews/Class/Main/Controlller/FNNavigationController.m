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
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
}

+ (void)setNavBarTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:[UIColor redColor]];
    
}

+ (void)setNavBarButtonTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *attres = [NSMutableDictionary dictionary];
    attres[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attres[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [item setTintColor:[UIColor whiteColor]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginImage:[UIImage imageNamed:@"navigationbar_back"]] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
       
    }
    // 在FNNewsPhotoSetController控制器下导航栏隐藏
    if ([viewController isKindOfClass:[FNNewsPhotoSetController class]]) {
        self.navigationBarHidden = YES;
    } else {
        self.navigationBarHidden = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    // 在FNNewsPhotoSetController控制器下导航栏隐藏
    if ([self.topViewController isKindOfClass:[FNNewsPhotoSetController class]]) {
        self.navigationBarHidden = NO;
    }
    [super popViewControllerAnimated:animated];
    return self.topViewController;
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


#pragma mark - UIGestureRecognizerDelegate


@end
