//
//  AVViewController.m
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVViewController.h"
#import "FNAVGetAllColumns.h"
#import "FNAVListController.h"

@implementation FNAVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [FNAVGetAllColumns getAllColumns:^(NSArray *array) {
        [self setAllChildControllerWithArray:array];
        [self setAllPrepare];
    }];
}
// 添加所有子控制器
- (void)setAllChildControllerWithArray:(NSArray *)dicArray
{
    for (NSDictionary *dic in dicArray) {
        FNAVListController *listVC = [[FNAVListController alloc] init];
        listVC.title = dic[@"tname"];
        listVC.tid = dic[@"tid"];
        [self addChildViewController:listVC];
    }
}


@end
