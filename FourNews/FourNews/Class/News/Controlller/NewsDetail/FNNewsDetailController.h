//
//  FNNewsDetailController.h
//  FourNews
//
//  Created by admin on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewsDetailItem.h"
#import "FNNewsListItem.h"

@interface FNNewsDetailController : UIViewController

@property (nonatomic, strong) FNNewsDetailItem *detailItem;

@property (nonatomic, strong) FNNewsListItem *listItem;


@end
