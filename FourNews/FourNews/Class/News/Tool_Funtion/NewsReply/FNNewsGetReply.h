//
//  FNNewsGetReply.h
//  FourNews
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNNewsDetailItem.h"

@interface FNNewsGetReply : NSObject

+ (void)hotReplyWithDetailItem:(FNNewsDetailItem *)item :(void(^)(NSArray *))compelet;

+ (void)newReplyWithDetailItem:(FNNewsDetailItem *)item :(NSInteger)replyPage :(void(^)(NSArray *))compelet;

@end
