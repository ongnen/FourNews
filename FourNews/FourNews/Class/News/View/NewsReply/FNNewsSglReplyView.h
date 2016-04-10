//
//  FNNewsSglReplyView.h
//  FourNews
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewsReplyItem.h"

@interface FNNewsSglReplyView : UIView

+ (instancetype)sglReplyViewWithItem:(FNNewsReplyItem *)replyItem;

- (instancetype)initWithItem:(FNNewsReplyItem *)replyItem;

@property (nonatomic, strong) FNNewsReplyItem *replyItem;

@property (nonatomic, assign) CGFloat totalHeight;

@end
