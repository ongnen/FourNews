//
//  FNADItem.h
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNADItem : NSObject

/** 广告图片*/
@property (nonatomic ,strong) NSString *w_picurl;
/** 广告界面跳转地址*/
@property (nonatomic ,strong) NSString *ori_curl;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;


@end
