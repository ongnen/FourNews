//
//  FNReadListItem.m
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNReadListItem.h"
#import <MJExtension.h>

@implementation FNReadListItem

MJCodingImplementation

- (CGFloat)cellHeight
{
    if (!_imgnewextra) {
        return 120;
    } else {
        CGFloat titleH = [_title boundingRectWithSize:CGSizeMake(FNScreenW-YJMargin*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
        return titleH + 0.6*FNScreenW + 40 + YJMargin*2;
    }
}

@end
