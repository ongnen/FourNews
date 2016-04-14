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

@interface FNMeSettingController ()

@end

@implementation FNMeSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置分隔线
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"清理缓存";
        NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1lfM",[FNFileManager getSizeWithFilePath:cache]/1000000.0];
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"清除浏览记录";
        NSMutableArray *historySkim = [[FNUserDefaults objectWithKey:@"historySkim"] mutableCopy];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld条",historySkim.count];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [FNFileManager clearDiskWithFilePath:cache];
        [MBProgressHUD showSuccess:@"清理完成"];
        
        [self.tableView reloadData];
    }
    if (indexPath.row == 1) {
        NSMutableArray *historySkim = [NSMutableArray array];
        [FNUserDefaults setObject:historySkim forKey:@"historySkim"];
        [MBProgressHUD showSuccess:@"清清除完成"];
        
        [self.tableView reloadData];
    }
}

@end
