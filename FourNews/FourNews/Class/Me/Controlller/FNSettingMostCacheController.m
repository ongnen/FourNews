//
//  FNSettingMostCacheController.m
//  FourNews
//
//  Created by admin on 16/5/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNSettingMostCacheController.h"

@interface FNSettingMostCacheController ()

@property (nonatomic, strong) YJSettingSelectedItem *selectedItem;

@end

@implementation FNSettingMostCacheController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addGroup1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.scrollEnabled = NO;
//    [self setDrawSetttingImage];
}
/** 拿到评论区截图 */
- (UIImage *)setDrawSetttingImage
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(FNScreenW, FNScreenH-64), NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 将图片导入桌面
    NSData *data = UIImagePNGRepresentation(image);
//    [data writeToFile:[NSString stringWithFormat:@"/Users/zyj/Desktop/imag1.png"]atomically:YES];
    return image;
}

- (void)addGroup1
{
    YJSettingSelectedItem *item1 = [[YJSettingSelectedItem alloc] init];
    item1.title = @"100M";
    __weak typeof(YJSettingSelectedItem *) weakItem1 = item1;
    __weak typeof(self) weakSelf = self;
    
    
    YJSettingSelectedItem *item2 = [[YJSettingSelectedItem alloc] init];
    item2.selected = NO;
    item2.title = @"200M";
    __weak typeof(YJSettingSelectedItem *) weakItem2 = item2;
    
    
    YJSettingSelectedItem *item3 = [[YJSettingSelectedItem alloc] init];
    item3.selected = NO;
    item3.title = @"400M";
    __weak typeof(YJSettingSelectedItem *) weakItem3 = item3;
    
    
    YJSettingSelectedItem *item4 = [[YJSettingSelectedItem alloc] init];
    item4.selected = NO;
    item4.title = @"800M";
    __weak typeof(YJSettingSelectedItem *) weakItem4 = item4;
    
    
    YJSettingSelectedItem *item5 = [[YJSettingSelectedItem alloc] init];
    item5.selected = NO;
    item5.title = @"1G";
    __weak typeof(YJSettingSelectedItem *) weakItem5 = item5;
    
    YJSettingGroupItem *group1 = [[YJSettingGroupItem alloc] init];
    group1.items = @[item1,item2,item3,item4,item5];
    [self.groupArray addObject:group1];
    
    switch ([FNUserDefaults integerForKey:@"mostCache"]) {
        case 100:
            item1.selected = YES;
            self.selectedItem = item1;
            break;
        case 200:
            item2.selected = YES;
            self.selectedItem = item2;
            break;
        case 400:
            item3.selected = YES;
            self.selectedItem = item3;
            break;
        case 800:
            item4.selected = YES;
            self.selectedItem = item4;
            break;
        case 1024:
            item5.selected = YES;
            self.selectedItem = item5;
            break;
        default:
            break;
    }
    
    item1.option = ^{
        weakItem1.selected = !weakItem1.isSelected;
        weakSelf.selectedItem.selected = !weakSelf.selectedItem.isSelected;
        weakSelf.selectedItem = weakItem1;
        [weakSelf.tableView reloadData];
        [FNUserDefaults setInteger:100 forKey:@"mostCache"];
    };
    item2.option = ^{
        weakItem2.selected = !weakItem2.isSelected;
        weakSelf.selectedItem.selected = !weakSelf.selectedItem.isSelected;
        weakSelf.selectedItem = weakItem2;
        [weakSelf.tableView reloadData];
        [FNUserDefaults setInteger:200 forKey:@"mostCache"];

    };
    item3.option = ^{
        weakItem3.selected = !weakItem3.isSelected;
        weakSelf.selectedItem.selected = !weakSelf.selectedItem.isSelected;
        weakSelf.selectedItem = weakItem3;
        [weakSelf.tableView reloadData];
        [FNUserDefaults setInteger:400 forKey:@"mostCache"];

    };
    item4.option = ^{
        weakItem4.selected = !weakItem4.isSelected;
        weakSelf.selectedItem.selected = !weakSelf.selectedItem.isSelected;
        weakSelf.selectedItem = weakItem4;
        [weakSelf.tableView reloadData];
        [FNUserDefaults setInteger:800 forKey:@"mostCache"];

    };
    item5.option = ^{
        weakItem5.selected = !weakItem5.isSelected;
        weakSelf.selectedItem.selected = !weakSelf.selectedItem.isSelected;
        weakSelf.selectedItem = weakItem5;
        [weakSelf.tableView reloadData];
        [FNUserDefaults setInteger:1024 forKey:@"mostCache"];

    };
    
    
}



@end
