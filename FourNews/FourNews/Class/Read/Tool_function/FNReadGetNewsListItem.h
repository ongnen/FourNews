//
//  FNReadGetNewsListItem.h
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNReadGetNewsListItem : NSObject

+ (void)getNewsListItemsWithCount:(NSInteger)count :(void(^)(NSArray *))complete;

@end
