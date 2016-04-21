//
//  FNNewsDetailItem.h
//  FourNews
//
//  Created by admin on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNNewsDetailContImgItem.h"

@interface FNNewsDetailItem : NSObject
// 发布时间
@property (nonatomic, strong) NSString *ptime;
// 来源
@property (nonatomic, strong) NSString *source;
// 责任编辑
@property (nonatomic, strong) NSString *ec;
// 新闻标题
@property (nonatomic, strong) NSString *title;
// 图集
@property (nonatomic, strong) NSArray *img;
// 评论数
@property (nonatomic, assign) NSInteger replyCount;
// 新闻文字内容
@property (nonatomic, strong) NSString *body;
// 能被搜索到的关键字
@property (nonatomic, strong) NSArray *keyword_search;
// 相关新闻
@property (nonatomic, strong) NSArray *relative_sys;
// 关键字
@property (nonatomic, strong) NSString *dkeys;
// 评论接口的参数
@property (nonatomic, strong) NSString *docid;
// 评论接口的参数
@property (nonatomic, strong) NSString *replyBoard;
// 详情页的热门评论
@property (nonatomic, strong) NSArray *replys;
// 分享链接
@property (nonatomic, strong) NSString *shareLink;

@property (nonatomic, strong) NSString *tid;
//@property (nonatomic, strong) NSArray *boboList;replyBoard
//@property (nonatomic, strong) NSArray *apps;
//@property (nonatomic, strong) NSArray *topiclist_news;
//@property (nonatomic, strong) NSArray *ydbaike;
//@property (nonatomic, assign) BOOL picnews;
//@property (nonatomic, strong) NSString *source_url;
//@property (nonatomic, strong) NSString *template;
//@property (nonatomic, assign) BOOL hasNext;
//@property (nonatomic, strong) NSArray *topiclist;
//@property (nonatomic, strong) NSArray *votes;
//@property (nonatomic, assign) NSInteger threadAgainst;
//@property (nonatomic, strong) NSString *voicecomment;
//@property (nonatomic, strong) NSArray *users;
//@property (nonatomic, assign) NSInteger threadVote;
//@property (nonatomic, strong) NSString *digest;

@end
