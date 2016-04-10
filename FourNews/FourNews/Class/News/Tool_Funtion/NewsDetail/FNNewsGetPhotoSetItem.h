//
//  FNNewsGetPhotoSetItem.h
//  FourNews
//
//  Created by admin on 16/4/5.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNNewsGetPhotoSetItem : NSObject

+ (void)getNewsDetailWithPhotoid:(NSString *)photoid :(void (^)(id))complete;

@end
