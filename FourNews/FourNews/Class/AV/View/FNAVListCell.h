//
//  FNAVListCell.h
//  FourNews
//
//  Created by admin on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNAVListItem.h"

@interface FNAVListCell : UITableViewCell

@property (nonatomic, strong) FNAVListItem *listItem;

@property (nonatomic, weak) UIButton *replyButton;

+ (CGFloat)totalHeightWithTitle:(NSString *)title;

@property (nonatomic, strong) void(^movieBlock)(NSString *,UIView *);

@property (nonatomic, strong) void(^replyBlock)(FNAVListItem *);


@end
