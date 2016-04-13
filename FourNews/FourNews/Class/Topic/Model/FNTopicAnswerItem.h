//
//  FNTopicAnswerItem.h
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNTopicAnswerItem : NSObject

@property (nonatomic, strong) NSString *answerId;

@property (nonatomic, strong) NSString *board;

@property (nonatomic, strong) NSString *commentId;

@property (nonatomic, strong) NSString *relatedQuestionId;
//
@property (nonatomic, strong) NSString *answerContent;

@property (nonatomic, strong) NSString *specialistHeadPicUrl;
@property (nonatomic, strong) NSString *supportCount;
@property (nonatomic, strong) NSString *replyCount;
@property (nonatomic, strong) NSString *answerTime;

@property (nonatomic, strong) NSString *specialistName;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *answerCount;
@end

//"answerId":"ANSWER5831584201756739889",
//"board":"3g_bbs",
//"commentId":"BK50C7UR009617BE",
//"relatedQuestionId":"QUESTION6607951386972277876",
//"content":"所谓黄，其实就是跟性相关。比如暴露男性或者女性敏感部位，各种色情行为色情场景色情镜头，非常接近人类性器官的物品等等。 正经回答，快点赞。",
//"specialistName":"马赛克",
//"specialistHeadPicUrl":"http://dingyue.nosdn.127.net/yCbSwMuL7dHQSAMGiMHNPKVA71ppLqb8In3LrRY9JR69B1460014447756.jpg",
//"supportCount":204,
//"replyCount":2,
//"cTime":1460100992516
