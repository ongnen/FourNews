//
//  FNTopicDetailHeaderView.h
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNTopicListItem.h"
#import "FNTopicDetailHeaderVBottomView.h"

@interface FNTopicDetailHeaderView : UIView

+ (instancetype)topicDetailHeaderViewWithListItem:(FNTopicListItem *)listItem;

@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, strong) void(^detailBlock)(FNTopicDetailHeaderView *);

@property (nonatomic, strong) void(^bottonSegueBlock)();

@property (nonatomic, weak) FNTopicDetailHeaderVBottomView *bottomV;

@end
