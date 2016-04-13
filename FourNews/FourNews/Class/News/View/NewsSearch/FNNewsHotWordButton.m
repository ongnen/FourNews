
//
//  FNNewsHotWordButton.m
//  FourNews
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsHotWordButton.h"

@implementation FNNewsHotWordButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.titleLabel.frame = CGRectMake(10, 10, self.width-20, self.height-20);
    
}

@end
