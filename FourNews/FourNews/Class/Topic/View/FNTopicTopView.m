//
//  FNTopicTopView.m
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicTopView.h"

@interface FNTopicTopView()

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation FNTopicTopView

- (void)awakeFromNib
{
    [self.backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)backBtnClick
{
    if (self.backBlock) {
        self.backBlock();
    }
}

@end
