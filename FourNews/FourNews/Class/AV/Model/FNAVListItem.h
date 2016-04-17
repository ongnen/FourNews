//
//  FNAVListItem.h
//  FourNews
//
//  Created by admin on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNAVListItem : NSObject
// 左下角视频类别图片
@property (nonatomic, strong) NSString *topicImg;
// 视频遮盖
@property (nonatomic, strong) NSString *cover;
// 评论数
@property (nonatomic, strong) NSString *replyCount;
// 视频来源
@property (nonatomic, strong) NSString *videosource;
// 主题描述
@property (nonatomic, strong) NSString *topicDesc;
// 标题
@property (nonatomic, strong) NSString *title;
// 视频地址
@property (nonatomic, strong) NSString *mp4_url;
// 评论参数
@property (nonatomic, strong) NSString *replyid;
// 视频长度
@property (nonatomic, strong) NSString *length;
// 左下角主题名
@property (nonatomic, strong) NSString *topicName;
// 发布日期
@property (nonatomic, strong) NSString *ptime;
// 新闻描述
@property (nonatomic, strong) NSString *descrip;

@property (nonatomic, strong) NSString *replyBoard;

@property (nonatomic, assign) NSInteger playCount;

@end
