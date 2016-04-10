//
//  FNNewsDetailContView.h
//  FourNews
//
//  Created by xmg on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewsDetailItem.h"
#import "FNNewsRelativeItem.h"

@interface FNNewsDetailContView : UIScrollView

@property (nonatomic, strong) FNNewsDetailItem *detailItem;

@property (nonatomic, strong) NSArray *replyArray;

@property (nonatomic, strong) FNNewsRelativeItem *relativeItem;

@property (nonatomic, strong) void(^relativeBlock)(NSString *);

@property (nonatomic, strong) void(^replyBlock)();

@property (nonatomic, strong) void(^lastKeyWordBtnClick)(NSString *);

@property (nonatomic, assign) CGFloat totalHeight;

@end
