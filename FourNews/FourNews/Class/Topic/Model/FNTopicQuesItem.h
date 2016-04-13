//
//  FNTopicQuesItem.h
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNTopicQuesItem : NSObject


@property (nonatomic, strong) NSString *questionId;
//
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *relatedExpertId;
//
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *userHeadPicUrl;
//
@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSString *quesTime;

@property (nonatomic, strong) NSString *questionCount;


@end

//"questionId":"QUESTION6607951386972277876",
//"content":"黄与不黄的界限在哪里啊？又没什么参考书推荐一下，能有鉴别规范手册之类的最好了~",
//"relatedExpertId":"EX7353104783909083695",
//"userName":"WindMoon",
//"userHeadPicUrl":"http://imgm.ph.126.net/K3UpQ3Bncd0Mrno3NTo1AA==/3886325003544106529.jpg",
//"state":"replied",
//"cTime":1460092473191
