//
//  FNPlayerViewController.h
//  FourNews
//
//  Created by xmg on 16/4/15.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <AVKit/AVKit.h>

@interface FNPlayerViewController : AVPlayerViewController <NSCopying,NSMutableCopying>

+ (instancetype)sharePlayerViewController;

@end
