//
//  FNStatusParamModel.h
//  FourNews
//
//  Created by admin on 16/5/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNStatusParamModel : NSObject

/** 从缓存中取多少条 */
@property (nonatomic, assign) NSInteger count;
/** 时间唯一标识 */
@property (nonatomic, assign) NSInteger timeid;
/** 模型名字 */
@property (nonatomic, strong) NSString *modelName;

@end
