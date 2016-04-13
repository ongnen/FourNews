//
//  FNNewsSglReplyView.m
//  FourNews
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#define FNNewsReplyBorder3 3
#define FNNewsReplyBorder5 5
#define FNNewsReplyBorder10 10
#define FNNewsReplyFont10 [UIFont systemFontOfSize:10]
#define FNNewsReplyFont14 [UIFont systemFontOfSize:14]
#define FNNewsReplyFont16 [UIFont systemFontOfSize:16]
#define FNNewsReplyColor150 FNColor(150, 150, 150)
#define FNNewsReplyColor180 FNColor(180, 180, 180)
#define FNNewsReplyColor200 FNColor(200, 200, 200)
#define FNNewsReplyColor220 FNColor(220, 220, 220)

#import "FNNewsSglReplyView.h"
#import <UIImageView+WebCache.h>
#import "NSString+YJ.h"

@interface FNNewsSglReplyView ()

@property (nonatomic, weak) UIImageView *iconV;

@property (nonatomic, weak) UILabel *nameL;
@property (nonatomic, weak) UILabel *sourceL;
@property (nonatomic, weak) UILabel *timeL;
@property (nonatomic, weak) UILabel *contentL;
@property (nonatomic, weak) UILabel *supportL;


@end

@implementation FNNewsSglReplyView

- (instancetype)initWithItem:(FNNewsReplyItem *)replyItem
{
    self = [super init];
    _replyItem = replyItem;
    
    [self setAllSubviews];
    
    [self setSubviewsFrame];
    
    return self;
}

+ (instancetype)sglReplyViewWithItem:(FNNewsReplyItem *)replyItem
{
    return [[FNNewsSglReplyView alloc] initWithItem:replyItem];;
}

- (void)setAllSubviews
{
    UIImageView *iconV = [[UIImageView alloc] init];
    [iconV sd_setImageWithURL:[NSURL URLWithString:_replyItem.timg]];
    if (_replyItem.timg == nil) {
        iconV.image = [UIImage imageNamed:@"tabbar_icon_me_normal"];
    }
    [self addSubview:iconV];
    self.iconV = iconV;
    
    UILabel *nameL = [[UILabel alloc] init];
    nameL.font = FNNewsReplyFont14;
    nameL.text = _replyItem.n;
    nameL.textColor = FNColorAlpha(0, 0, 200, 0.7);
    [self addSubview:nameL];
    self.nameL = nameL;
    
    UILabel *sourceL = [[UILabel alloc] init];
    _replyItem.f = [_replyItem.f stringByReplacingOccurrencesOfString:@"网易" withString:@""];
    if ([_replyItem.f containsString:@"市"]) {
        NSInteger loc = [_replyItem.f rangeOfString:@"市"].location;
        _replyItem.f = [_replyItem.f substringToIndex:loc+1];
    }else if([_replyItem.f containsString:@"省"]) {
        NSInteger loc = [_replyItem.f rangeOfString:@"省"].location;
        _replyItem.f = [_replyItem.f substringToIndex:loc+1];
    } else {
        _replyItem.f = [_replyItem.f substringToIndex:2];
    }
    sourceL.text = _replyItem.f;
    sourceL.font = FNNewsReplyFont10;
    sourceL.textColor = FNNewsReplyColor150;
    [self addSubview:sourceL];
    self.sourceL = sourceL;
    
    UILabel *timeL = [[UILabel alloc] init];
    timeL.font = FNNewsReplyFont10;
    timeL.textColor = FNNewsReplyColor150;
    timeL.text = [NSString dateStringWithString:_replyItem.t :@"yyyy-MM-dd HH:mm:ss"];
    [self addSubview:timeL];
    self.timeL = timeL;
    
    UILabel *contentL = [[UILabel alloc] init];
    contentL.font = FNNewsReplyFont16;
    contentL.text = _replyItem.b;
    contentL.numberOfLines = 0;
    [self addSubview:contentL];
    self.contentL = contentL;
    
    UILabel *supportL = [[UILabel alloc] init];
    supportL.font = FNNewsReplyFont10;
    _replyItem.v = [_replyItem.v stringByAppendingString:@"顶"];
    supportL.text = _replyItem.v;
    [self addSubview:supportL];
    self.supportL = supportL;
}

- (void)setSubviewsFrame
{
    CGFloat iconX = 10;
    CGFloat iconY = 10;
    CGFloat iconW = 25;
    CGFloat iconH = 25;
    self.iconV.layer.cornerRadius = iconW/2.0;
    self.iconV.layer.masksToBounds = YES;
    self.iconV.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = iconX+iconW+FNNewsReplyBorder5;
    CGFloat nameY = iconY;
    CGSize nameSize = [_replyItem.n sizeWithAttributes:@{NSFontAttributeName:FNNewsReplyFont14}];
    self.nameL.frame = (CGRect){nameX,nameY,nameSize};
    
    CGFloat sourceX = nameX;
    CGFloat sourceY = nameY+nameSize.height+FNNewsReplyBorder3;
    CGSize sourceSize = [_replyItem.f sizeWithAttributes:@{NSFontAttributeName:FNNewsReplyFont10}];
    self.sourceL.frame = (CGRect){sourceX,sourceY,sourceSize};
    
    CGFloat timeX = sourceX+sourceSize.width+FNNewsReplyBorder3;
    CGFloat timeY = sourceY;
    CGSize timeSize = [_replyItem.t sizeWithAttributes:@{NSFontAttributeName:FNNewsReplyFont10}];
    self.timeL.frame = (CGRect){timeX,timeY,timeSize};
    
    CGSize supportSize = [_replyItem.v sizeWithAttributes:@{NSFontAttributeName:FNNewsReplyFont10}];
    CGFloat supportX = self.width-supportSize.width-FNNewsReplyBorder10;
    CGFloat supportY = 2*FNNewsReplyBorder10;
    self.supportL.frame = (CGRect){supportX,supportY,supportSize};
    
    CGFloat contentX = nameX;
    CGFloat contentY = sourceY+sourceSize.height+FNNewsReplyBorder10+FNNewsReplyBorder3;
    CGSize contentSize = [_replyItem.b boundingRectWithSize:CGSizeMake(FNScreenW-70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FNNewsReplyFont16} context:nil].size;
    self.contentL.frame = (CGRect){contentX,contentY,contentSize};
    
    _totalHeight = contentY+contentSize.height+FNNewsReplyBorder5;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
