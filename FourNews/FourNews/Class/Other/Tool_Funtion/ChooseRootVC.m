//
//  ChooseRootVC.m
//  网易彩票2016
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "ChooseRootVC.h"
#import "FNUserDefaults.h"
#import "FNTabBarController.h"
#import "NewFeatureController.h"

@implementation ChooseRootVC

+ (UIViewController *)chooseRootViewController
{
    // 沙盒中的版本号
//    NSString *lastVersion = [FNUserDefaults objectWithKey:@"lastVersion"];
    // 获得当前版本号
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    // 判断返回根控制器
//    if ([currentVersion isEqualToString:lastVersion]) {
//        return [[FNTabBarController alloc] init];
//    } else {
//        return [[NewFeatureController alloc] init];
//    }
    return [[FNTabBarController alloc] init];
}

@end
