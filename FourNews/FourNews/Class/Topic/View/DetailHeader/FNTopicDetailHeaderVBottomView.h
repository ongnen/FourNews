//
//  FNTopicDetailHeaderVBottomView.h
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FNTopicDetailHeaderVBottomView : UIView

@property (weak, nonatomic) IBOutlet UILabel *messageL;

@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseSegment;

@property (nonatomic, strong) void(^segueBlock)();

@end
