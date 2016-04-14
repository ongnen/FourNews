//
//  FNNewsListItem.m
//  FourNews
//
//  Created by xmg on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsListItem.h"
#import "FNNewsADsItem.h"
#import <MJExtension.h>

@implementation FNNewsListItem

MJCodingImplementation

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"ads":@"FNNewsADsItem"};
}

- (CGFloat)totalHeight
{
    if (_imgextra) {
        return FNNewsListCellHeightTypeThr;
    } else {
        return FNNewsListCellHeightTypeSgl;
    }
}


@end
