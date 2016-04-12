//
//  FNTopicDetailInsetView.m
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicDetailInsetView.h"

@interface FNTopicDetailInsetView ()



@end

@implementation FNTopicDetailInsetView

+ (instancetype)TopicDetailInsetViewWith:(FNTopicListItem *)listItem
{
    FNTopicDetailInsetView *insetView = [[NSBundle mainBundle] loadNibNamed:@"FNTopicDetailInsetView" owner:nil options:0].lastObject;
    insetView.descL.text = listItem.alias;
    insetView.descL.textColor = [UIColor whiteColor];
    insetView.descL.numberOfLines = 0;
    insetView.descL.font = [UIFont systemFontOfSize:15];
    
    NSString *concernCountStr = [NSString stringWithFormat:@"%d",[listItem.concernCount intValue]];
    if ([listItem.concernCount intValue]>9999) {
        concernCountStr =  [NSString stringWithFormat:@"%0.1f万",[listItem.concernCount intValue]/10000.0];
    }
    insetView.focuL.text = [NSString stringWithFormat:@"—— %@ 关注 ——",concernCountStr];
    insetView.focuL.textColor = [UIColor whiteColor];
    insetView.focuL.font = [UIFont systemFontOfSize:12];
    
    insetView.focuV.layer.cornerRadius = 12.5;
    insetView.focuV.clipsToBounds = YES;
    
    return insetView;
}



@end
