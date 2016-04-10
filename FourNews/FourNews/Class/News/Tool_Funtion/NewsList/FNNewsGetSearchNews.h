//
//  FNNewsGetSearchNews.h
//  FourNews
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNNewsGetSearchNews : NSObject

+ (void)getSearchNewsWithWord:(NSString *)word :(void(^)(NSArray *))complete;;

@end
