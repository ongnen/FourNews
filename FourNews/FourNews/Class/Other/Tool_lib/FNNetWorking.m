//
//  FNNetWorking.m
//  FourNews
//
//  Created by xmg on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNetWorking.h"
#import "FNHTTPManager.h"
#import <AFNetworking.h>

@implementation FNNetWorking

+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id, NSURLSessionDataTask *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))taskError{
    FNHTTPManager *manager = [FNHTTPManager manager];
    
    return [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        taskError(task,error);
    }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id, NSURLSessionDataTask *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))taskError{
    
    FNHTTPManager *manager = [FNHTTPManager manager];
    
    return [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        taskError(task,error);
    }];
    
}


@end
