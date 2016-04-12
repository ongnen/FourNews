//
//  FNTopicDetailCellAnsView.h
//  FourNews
//
//  Created by xmg on 16/4/12.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNTopicAnswerItem.h"

@interface FNTopicDetailCellAnsView : UIView

+ (instancetype)ansViewWithItem:(FNTopicAnswerItem *)ansItem;

@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, strong) FNTopicAnswerItem *ansItem;

@end
