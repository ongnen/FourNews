//
//  YJGridView.h
//  支付宝
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJGridItemListButton,YJGridButtonitem,YJGridItemListView;

@interface YJGridView : UIView

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) NSArray *imageArray;

+ (instancetype)gridViewWithlist:(NSArray *)items;

@property (nonatomic, copy) void(^listBtnClickBlock)(YJGridItemListButton *btn);

@end

@interface YJGridItemListButton : UIButton

@property (nonatomic, strong) NSString *url;

@end

@interface YJGridItemListView : UIView

@property (nonatomic, strong) YJGridButtonitem *item;

@property (atomic, assign) NSInteger index;

@property (nonatomic, copy) void(^btnClickBlock)(YJGridItemListButton *btn);

@property (nonatomic, copy) void(^btnLongPress)(UILongPressGestureRecognizer *longP);

@end

@interface YJGridButtonitem : NSObject

@property (nonatomic, strong) NSString *image;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) NSInteger index;


@end

