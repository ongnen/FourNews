//
//  FNNetWorking.h
//  FourNews
//
//  Created by xmg on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNNetWorking : UIViewController

+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject,NSURLSessionDataTask * task))success failure:(void(^)(NSURLSessionDataTask *task,NSError *error))taskError;

+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject,NSURLSessionDataTask * task))success failure:(void(^)(NSURLSessionDataTask *task,NSError *error))taskError;



@end
