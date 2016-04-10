//
//  FNNewsSearchListController.m
//  FourNews
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsSearchListController.h"
#import "FNNewsSearchListCell.h"
#import "FNNewsDetailController.h"
#import "FNNewsGetDetailNews.h"

@interface FNNewsSearchListController ()

@end

@implementation FNNewsSearchListController
static NSString * const ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 70;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FNNewsSearchListCell" bundle:nil] forCellReuseIdentifier:ID];
}

- (void)setSearchItems:(NSArray<FNNewsSearchWordItem *> *)searchItems
{
    _searchItems = searchItems;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.searchItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FNNewsSearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    FNNewsSearchWordItem *item = self.searchItems[indexPath.row];
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.跳转
    FNNewsDetailController *detailVC = [[FNNewsDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];    // 传数据
    [FNNewsGetDetailNews getNewsDetailWithDocid:self.searchItems[indexPath.row].docid :^(FNNewsDetailItem *item) {
        detailVC.detailItem = item;
    }];
}
@end
