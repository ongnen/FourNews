//
//  FNNewsHistoryView.h
//  FourNews
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewsListItem.h"

@interface FNNewsHistoryView : UIView

@property (nonatomic, strong) NSString *detailID;


@property (nonatomic, strong) void(^historyBlock)(id);

@property (nonatomic, strong) void(^moreBlock)();

@end
