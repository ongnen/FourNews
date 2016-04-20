//
//  FNReadListItem.h
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNReadListItem : NSObject

@property (nonatomic, assign) NSInteger downTimes;

@property (nonatomic, strong) NSString *source;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSInteger imgType;

@property (nonatomic, strong) NSString *img;

@property (nonatomic, assign) NSInteger picCount;

@property (nonatomic, strong) NSArray *unlikeReason;

@property (nonatomic, strong) NSString *docid;

@property (nonatomic, strong) NSString *imgsrc;

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, strong) NSString *ptime;

@property (nonatomic, strong) NSString *pixel;

//@property (nonatomic, strong) NSString *template;

@property (nonatomic, strong) NSArray *imgnewextra;

@property (nonatomic, assign) NSInteger upTime;

//@property (nonatomic, strong) NSString *id;

@property (nonatomic, assign) CGFloat cellHeight;

@end
//"boardid":"ent2_bbs",
//"clkNum":0,
//"digest":"宋仲基的妹妹近照曝光，眉眼之间与哥哥如出一辙。",
//"docid":"BKEVB8J400031H2L",
//"downTimes":5,
//"id":"BKEVB8J400031H2L",
//"img":"http://img4.cache.netease.com/3g/2016/4/12/201604121253529e1ff.jpg",
//"imgType":0,
//"imgsrc":"http://img4.cache.netease.com/3g/2016/4/12/201604121253529e1ff.jpg",
//"picCount":1,
//"pixel":"270*202",
//"program":"HY",
//"prompt":"成功为您推荐20条新内容",
//"recType":-1,
//"replyCount":5730,
//"replyid":"BKEVB8J400031H2L",
//"source":"网易娱乐专稿",
//"template":"normal",
//"title":"你们的小姑子，宋仲基妹妹从小胖子变成了美女！",
//"unlikeReason":[
//                "娱乐/1",
//                "很黄很暴力/6",
//                "标题党/6",
//                "宋仲基/3",
//                "来源:网易娱乐专稿/4",
//                "内容重复/6"
//                ],
//"upTimes":3