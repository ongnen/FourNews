//
//  FNTopicDetailInsetView.h
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNTopicListItem.h"

@interface FNTopicDetailInsetView : UIView

@property (weak, nonatomic) IBOutlet UILabel *descL;
@property (weak, nonatomic) IBOutlet UILabel *focuL;
@property (weak, nonatomic) IBOutlet UIView *focuV;


+ (instancetype)TopicDetailInsetViewWith:(FNTopicListItem *)listItem;

@end
