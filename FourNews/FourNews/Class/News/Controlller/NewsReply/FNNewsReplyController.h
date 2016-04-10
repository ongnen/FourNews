//
//  FNNewsReplyController.h
//  FourNews
//
//  Created by xmg on 16/4/4.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewsDetailItem.h"

@interface FNNewsReplyController : UITableViewController

@property (nonatomic, strong) NSString *docid;

@property (nonatomic, strong) NSString *boardid;

@property (nonatomic, strong) FNNewsDetailItem *item;

@end
