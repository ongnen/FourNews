//
//  FNNewsReplyItem.h
//  FourNews
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNNewsReplyItem : NSObject

// 昵称
@property (nonatomic, strong) NSString *n;
// 评论时间
@property (nonatomic, strong) NSString *t;
// 评论内容
@property (nonatomic, strong) NSString *b;
// 头像
@property (nonatomic, strong) NSString *timg;
// 点赞
@property (nonatomic, strong) NSString *v;
// 来源
@property (nonatomic, strong) NSString *f;

@end
