//
//  FNNewsPhotoDescView.h
//  FourNews
//
//  Created by xmg on 16/4/6.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewsPhotoSetItem.h"

@interface FNNewsPhotoDescView : UIView
@property (weak, nonatomic) IBOutlet UILabel *indexL;
@property (nonatomic, strong) FNNewsPhotoSetItem *descItem;

+ (CGFloat)heightWithPhotoSet:(NSArray *)photoSet;

@end
