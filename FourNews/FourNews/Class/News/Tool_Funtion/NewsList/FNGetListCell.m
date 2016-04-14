//
//  FNGetListCell.m
//  FourNews
//
//  Created by admin on 16/3/30.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNGetListCell.h"
#import "FNNewsSglImgCell.h"
#import "FNNewsThrImgCell.h"

static NSString * const ADCell = @"newsListCell0";
static NSString * const SglImg = @"newsListCell1";
static NSString * const ThrImg = @"newsListCell2";

@implementation FNGetListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView :(FNNewsListItem *)item :(NSIndexPath *)indexPath
{
    if (item.imgextra) {
        FNNewsThrImgCell *cell = [tableView dequeueReusableCellWithIdentifier:ThrImg];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FNNewsThrImgCell" owner:nil options:nil] lastObject];
        }
        return (id)cell;
    } else {
        FNNewsSglImgCell *cell = [tableView dequeueReusableCellWithIdentifier:SglImg];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FNNewsSglImgCell" owner:nil options:nil] lastObject];
        }
        return (id)cell;
    }
}


@end
