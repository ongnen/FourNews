//
//  UIView+YJ.m
//  test1
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIView+FN.h"

@implementation UIView (FN)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height);
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    self.frame = (CGRect){frame.origin.x, frame.origin.y, size};
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    self.frame = (CGRect){origin, frame.size.width,frame.size.height};
}

- (CGFloat)y
{
    return self.frame.origin.y;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

@end
