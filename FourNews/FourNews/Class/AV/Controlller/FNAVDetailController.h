//
//  FNAVDetailController.h
//  FourNews
//
//  Created by xmg on 16/4/17.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNAVListItem.h"

@interface FNAVDetailController : UIViewController

@property (nonatomic, strong) FNAVListItem *item;

@property (nonatomic, strong) void(^backBlock)();

@end
