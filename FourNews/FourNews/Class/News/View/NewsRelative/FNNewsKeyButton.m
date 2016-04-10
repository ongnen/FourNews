//
//  FNNewsKeyButton.m
//  FourNews
//
//  Created by xmg on 16/4/4.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsKeyButton.h"

@implementation FNNewsKeyButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return contentRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width*0.1, contentRect.size.height*0.2, contentRect.size.width*0.8, contentRect.size.height*0.5);
}

@end
