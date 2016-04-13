//
//  FNNewsReplyButton.m
//  FourNews
//
//  Created by admin on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsReplyButton.h"

@implementation FNNewsReplyButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.imageView.frame = self.bounds;
//    
//    self.titleLabel.frame = CGRectMake(self.bounds.origin.x+3, self.bounds.origin.y, self.bounds.size.width-4, self.bounds.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return contentRect;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.origin.x+3, contentRect.origin.y, contentRect.size.width-4, contentRect.size.height);
}

@end
