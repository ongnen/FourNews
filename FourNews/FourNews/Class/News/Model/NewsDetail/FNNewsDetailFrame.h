
//
//  FNNewsDetailFrame.h
//  FourNews
//
//  Created by xmg on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//
#define FNNewsDetailTopBorder 15
#define FNNewsDetailLeftBorder 10
#define FNNewsDetailAltBorder 3
#define FNNewsDetailContentBodyFont 18
#define FNNewsDetailContentPgTtFont 19
#define FNNewsDetailContentTitleFont 21
#define FNNewsDetailPTimeFont 12
#define FNNewsDetailSoureceFont 12
#define FNNewsDetailImgAltFont 14

#import <Foundation/Foundation.h>
#import "FNNewsDetailItem.h"
#import <UIKit/UIKit.h>

@interface FNNewsDetailFrame : NSObject
// 标题
@property (nonatomic, assign) CGRect titleF;
// 时间
@property (nonatomic, assign) CGRect pTimeF;
// 来源
@property (nonatomic, assign) CGRect sourceF;
// 图片
@property (nonatomic, strong) NSMutableArray *pictureFs;
// 总图片
@property (nonatomic, assign) CGFloat totalPicH;
// 图片描述
@property (nonatomic, strong) NSMutableArray *altFs;
// 文字内容
@property (nonatomic, assign) CGRect contentF;
// 分享
@property (nonatomic, assign) CGRect shareF;
// 评论
@property (nonatomic, assign) CGRect ecF;
// 评论
@property (nonatomic, assign) CGRect replyF;
// 相关
@property (nonatomic, assign) CGRect relativeF;

//@property (nonatomic, assign) CGRect topImgF;

// 总高度
@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, strong) FNNewsDetailItem *detailItem;



@end
