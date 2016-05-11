//
//  FNAVShareView.h
//  FourNews
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNAVListItem.h"

@interface FNAVShareView : UIView

@property (nonatomic, strong) FNAVListItem *item;

+ (instancetype)avShareView;

@property (nonatomic, strong) void(^closeBlock)();

@end
