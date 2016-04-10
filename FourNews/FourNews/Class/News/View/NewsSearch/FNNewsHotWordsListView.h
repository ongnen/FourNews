//
//  FNNewsHotWordsListView.h
//  FourNews
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewsHotWordItem.h"

@interface FNNewsHotWordsListView : UIView

@property (nonatomic, strong) NSArray<FNNewsHotWordItem *> *hotWords;

@property (nonatomic, strong) void(^hotWordBlock)(NSString *);


@end
