//
//  YJSettingGroupItem.h
//  网易彩票2016
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJSettingGroupItem : NSObject

//共有多少行
@property (nonatomic ,strong) NSArray *items;
//头部标题
@property (nonatomic ,strong) NSString *headerT;
//尾部标题
@property (nonatomic ,strong) NSString *footerT;


+ (instancetype)settingItemWithRowArray:(NSArray *)items;

@end
