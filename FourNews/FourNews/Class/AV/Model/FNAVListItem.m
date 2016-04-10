//
//  FNAVListItem.m
//  FourNews
//
//  Created by admin on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVListItem.h"
#import <MJExtension.h>

@implementation FNAVListItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"descrip":@"description"};
}

@end
