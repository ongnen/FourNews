//
//  FNNewsHistorySkimController.m
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsHistorySkimController.h"
#import "FNNewsSearchListCell.h"
#import "FNNewsPhotoSetController.h"
#import "FNNewsDetailController.h"
#import "FNNewsGetDetailNews.h"
#import "FNNewsGetReply.h"

@interface FNNewsHistorySkimController ()

@property (nonatomic, strong) NSArray *historySkims;

@end

@implementation FNNewsHistorySkimController
static NSString * const ID = @"cell";
- (NSArray *)historySkims
{
    if (!_historySkims){
        NSMutableArray *historySkim = [[FNUserDefaults objectWithKey:@"historySkim"] mutableCopy];
        NSMutableArray *skimArray = [NSMutableArray array];
        for (int i = 0; i<historySkim.count; i++) {
            id item = [NSKeyedUnarchiver unarchiveObjectWithData:historySkim[historySkim.count-i-1]];
            [skimArray addObject:item];
        }
        _historySkims = skimArray;
    }
    return _historySkims;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 70;

    [self.tableView registerNib:[UINib nibWithNibName:@"FNNewsSearchListCell" bundle:nil] forCellReuseIdentifier:ID];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.historySkims.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FNNewsSearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    FNNewsDetailItem *detailItem = self.historySkims[indexPath.row];
    FNNewsSearchWordItem *item = [[FNNewsSearchWordItem alloc] init];
    item.docid = detailItem.docid;
    item.title = detailItem.title;
    item.ptime = detailItem.ptime;
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.跳转
    [self historySkimBtnClickWithListItem:self.historySkims[indexPath.row]];
}
#pragma mark - 查看历史浏览
- (void)historySkimBtnClickWithListItem:(id)item
{
    if ([item isKindOfClass:[FNNewsListItem class]]) {
        FNNewsListItem *listItem = (FNNewsListItem *)item;
        if (listItem.photosetID) {
            FNNewsPhotoSetController *photoSetVC = [[FNNewsPhotoSetController alloc] init];
            photoSetVC.photoSetid = listItem.photosetID;
            photoSetVC.listItem = listItem;
            [self.navigationController pushViewController:photoSetVC animated:YES];
            
        } else {
            // 1.跳转
            FNNewsDetailController *detailVC = [[FNNewsDetailController alloc] init];
            [self.navigationController pushViewController:detailVC animated:YES];
            detailVC.listItem = listItem;
            // 传数据
            [FNNewsGetDetailNews getNewsDetailWithDocid:listItem.docid :^(FNNewsDetailItem *item) {
                [FNNewsGetReply hotReplyWithDetailItem:item :^(NSArray *array) {
                    if (array == nil) {
                    } else {
                        item.replys = array;
                    }
                    detailVC.detailItem = item;
                    
                }];
                
            }];
        }
    } else {
        FNNewsDetailItem *detailItem = (FNNewsDetailItem *)item;
        FNNewsDetailController *detailVC = [[FNNewsDetailController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
        // 传数据
        [FNNewsGetDetailNews getNewsDetailWithDocid:detailItem.docid :^(FNNewsDetailItem *item) {
            [FNNewsGetReply hotReplyWithDetailItem:item :^(NSArray *array) {
                if (array == nil) {
                } else {
                    item.replys = array;
                }
                detailVC.detailItem = item;
                
            }];
            
        }];
    }
    
}


@end
