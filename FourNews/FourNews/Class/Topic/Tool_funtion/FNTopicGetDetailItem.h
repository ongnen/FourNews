//
//  FNTopicGetDetailItem.h
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNTopicGetDetailItem : NSObject

+ (void)getTopicNewsDetailWithExpertId:(NSString *)expertId :(BOOL)isNewQues :(NSInteger)pageCount :(void(^)(NSMutableArray *))complete;




@end
