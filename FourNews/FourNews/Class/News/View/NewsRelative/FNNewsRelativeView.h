//
//  FNNewsRelativeView.h
//  FourNews
//
//  Created by xmg on 16/4/4.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNNewsRelativeItem.h"
#import "FNNewsDetailItem.h"

@interface FNNewsRelativeView : UIView

//+ (instancetype)relativeViewWithItem:(FNNewsRelativeItem *)relativeItem :(NSArray *)keyWords;
//
//- (instancetype)initWithItem:(FNNewsRelativeItem *)relativeItem :(NSArray *)keyWords;

@property (nonatomic, strong) FNNewsDetailItem *detailItem;

@property (nonatomic, assign) CGFloat totalHeight;

+ (CGFloat)totalHeightWithItem:(FNNewsDetailItem *)detailItem;

@property (nonatomic, strong) void(^keyWordBlock)(NSString *);

@end
