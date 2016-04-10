//
//  FNGetListCell.h
//  FourNews
//
//  Created by admin on 16/3/30.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FNNewsListItem;



@interface FNGetListCell : NSObject

+ (instancetype)cellWithTableView:(UITableView *)tableView :(FNNewsListItem *)item :(NSIndexPath *)indexPath;

@end
