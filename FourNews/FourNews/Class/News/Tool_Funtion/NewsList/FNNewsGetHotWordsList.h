//
//  FNNewsGetHotWordsList.h
//  FourNews
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNNewsGetHotWordsList : NSObject

+ (void)getHotWordList:(void(^)(NSArray *))complete;

@end
