//
//  FNNewsReplyCell.h
//  FourNews
//
//  Created by xmg on 16/4/4.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewsReplyItem.h"

@interface FNNewsReplyCell : UITableViewCell

@property (nonatomic, strong) FNNewsReplyItem *replyItem;

@property (nonatomic, assign) CGFloat totalHeight;

+ (CGFloat)totalHeightWithItem:(FNNewsReplyItem *)replyItem;

@end
