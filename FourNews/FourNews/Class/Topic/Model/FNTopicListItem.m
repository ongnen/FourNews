//
//  FNTopicListItem.m
//  FourNews
//
//  Created by xmg on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicListItem.h"
#import <MJExtension.h>

@implementation FNTopicListItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"descrip":@"description"};
}

@end
