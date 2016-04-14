//
//  FNMeGetSquareItem.h
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNMeGetSquareItem : NSObject

+ (NSURLSessionDataTask *)squareItem:(void (^)(NSArray *))complete;

@end
