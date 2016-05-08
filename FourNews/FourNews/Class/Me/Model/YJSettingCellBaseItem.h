//
//  YJSettingCelBaseItem.h
//  网易彩票2016
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJSettingCellBaseItem : NSObject

//图标
@property (nonatomic ,strong) UIImage *image;
//标题
@property (nonatomic ,strong) NSString *title;
//子标题
@property (nonatomic , strong) NSString *detailTitle;

//执行一段代码
@property (nonatomic, copy) void(^option)();


//快速创建模型
+ (instancetype)settingRowItemWithTitle:(NSString *)title image:(UIImage *)image;

@end
