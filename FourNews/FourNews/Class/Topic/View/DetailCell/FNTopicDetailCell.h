//
//  FNTopicDetailCell.h
//  FourNews
//
//  Created by xmg on 16/4/12.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNTopicDetailItem.h"
#import "FNTopicQuesItem.h"
#import "FNTopicAnswerItem.h"


@interface FNTopicDetailCell : UITableViewCell

@property (nonatomic, strong) FNTopicDetailItem *detailItem;

+ (CGFloat)totalHeightWithItem:(FNTopicDetailItem *)detailItem;

@end
