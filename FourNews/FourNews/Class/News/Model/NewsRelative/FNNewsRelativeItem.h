//
//  FNNewsRelativeItem.h
//  FourNews
//
//  Created by xmg on 16/4/4.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNNewsRelativeItem : NSObject
// 新文详情接口参数
@property (nonatomic, strong) NSString *id;
// 来源
@property (nonatomic, strong) NSString *source;
// 配图
@property (nonatomic, strong) NSString *imgsrc;
// 主标题
@property (nonatomic, strong) NSString *title;
// 发布时间
@property (nonatomic, strong) NSString *ptime;

@end