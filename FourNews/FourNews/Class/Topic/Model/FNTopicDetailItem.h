//
//  FNTopicDetailItem.h
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNTopicQuesItem.h"
#import "FNTopicAnswerItem.h"

@interface FNTopicDetailItem : NSObject

@property (nonatomic, strong) FNTopicQuesItem *question;

@property (nonatomic, strong) FNTopicAnswerItem *answer;

@property (nonatomic, assign) CGFloat totalHeight;


@end
