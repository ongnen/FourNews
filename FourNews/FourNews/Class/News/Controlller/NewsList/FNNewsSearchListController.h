//
//  FNNewsSearchListController.h
//  FourNews
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewsSearchWordItem.h"

@interface FNNewsSearchListController : UITableViewController

@property (nonatomic, strong) NSArray<FNNewsSearchWordItem *> *searchItems;

@end
