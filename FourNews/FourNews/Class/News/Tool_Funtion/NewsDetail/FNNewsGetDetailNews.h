//
//  FNNewsGetDetailNews.h
//  FourNews
//
//  Created by admin on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNNewsGetDetailNews : NSObject

+ (void)getNewsDetailWithDocid:(NSString *)docid :(void (^)(id))complete;


@end
