//
//  FNTopicDetailHeaderView.h
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNTopicListItem.h"

@interface FNTopicDetailHeaderView : UIView

+ (instancetype)topicDetailHeaderViewWithListItem:(FNTopicListItem *)listItem;

+ (CGFloat)totalHeightWithItem:(FNTopicListItem *)listItem;

@end
