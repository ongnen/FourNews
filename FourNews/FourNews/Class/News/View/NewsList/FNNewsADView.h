//
//  FNNewsADCell.h
//  FourNews
//
//  Created by xmg on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewsListItem.h"

@interface FNNewsADView : UIView


@property (nonatomic, strong) FNNewsListItem *contItem;

@property (nonatomic, strong) void(^adClickBlock)(FNNewsListItem *,NSInteger index);

@end
