//
//  FNTopicListItem.h
//  FourNews
//
//  Created by xmg on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNTopicListItem : NSObject

@property (nonatomic, strong) NSString *expertId;
// 图片下方的描述
@property (nonatomic, strong) NSString *alias;

@property (nonatomic, strong) NSString *name;
// 大图
@property (nonatomic, strong) NSString *picurl;

@property (nonatomic, strong) NSString *descrip;
// 类型
@property (nonatomic, strong) NSString *classification;

@property (nonatomic, strong) NSString *title;
// 头像
@property (nonatomic, strong) NSString *headpicurl;

@property (nonatomic, strong) NSString *questionCount;

@property (nonatomic, strong) NSString *answerCount;

@property (nonatomic, strong) NSString *createTime;
// 关注人数
@property (nonatomic, strong) NSString *concernCount;

@end


//"expertId":"EX05074551640631430414",
//"alias":"我是CUBA运动员邢洋，关于科比是否能以湖人的胜利完美收官，问我吧！",
//"stitle":"Cuba大神传授绝技",
//"picurl":"http://dingyue.nosdn.127.net/6onPFVab2e6k125AMNxDYvoIHU0CzSYGbC87kPY8xjBTE1460101586617.jpg",
//"name":"邢洋",
//"description":"我是邢洋，清华附中的助理教练，在大学期间曾代表化工大学连续五次获得北京市联赛冠军，并帮助学校破格由乙组升至甲组，有过五年的Cuba的比赛经历，且担任了五年的队长，之后一直留在队里担任助教。",
//"headpicurl":"http://dingyue.nosdn.127.net/HhOmbz0mBG9OByJYkICN0uQrUKSQH8sRDdLrWvu8LAzuB1460099059796.jpg",
//"classification":"体育",
//"state":1,
//"expertState":1,
//"concernCount":1125,
//"createTime":1460100657513,
//"title":"运动员",
//"questionCount":47,
//"answerCount":19




