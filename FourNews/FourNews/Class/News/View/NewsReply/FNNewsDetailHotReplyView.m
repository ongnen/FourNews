//
//  FNNewsDetailHotReplyView.m
//  FourNews
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 天涯海北. All rights reserved.
//
#define FNNewsReplyMargin 15
#import "FNNewsDetailHotReplyView.h"
#import "FNNewsReplyItem.h"
#import <UIImageView+WebCache.h>
#import "FNNewsSglReplyView.h"


@interface FNNewsDetailHotReplyView ()
@property (weak, nonatomic) IBOutlet UIView *lineZero;

@end

@implementation FNNewsDetailHotReplyView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (CGFloat)totalHeightWithReplyArray:(NSArray *)array
{
    FNNewsDetailHotReplyView *view = [[FNNewsDetailHotReplyView alloc] init];
    [view setReplyArray:array];
    return view.totalHeight;
}

- (void)setReplyArray:(NSArray *)replyArray
{
    _replyArray = replyArray;
    
    if (replyArray.count == 0)return;
    FNNewsReplyItem *reply1 = replyArray[0][0];
    FNNewsSglReplyView *sglReplyV1 = [FNNewsSglReplyView sglReplyViewWithItem:reply1];
    sglReplyV1.frame = CGRectMake(0, 30, self.width, sglReplyV1.totalHeight);
    [self addSubview:sglReplyV1];
    
    _totalHeight = sglReplyV1.height+sglReplyV1.frame.origin.y+FNNewsReplyMargin+40;
    
    if (replyArray.count == 1)return;
    FNNewsReplyItem *reply2 = replyArray[1][0];
    FNNewsSglReplyView *sglReplyV2 = [FNNewsSglReplyView sglReplyViewWithItem:reply2];
    sglReplyV2.frame = CGRectMake(0, sglReplyV1.height+sglReplyV1.frame.origin.y+FNNewsReplyMargin, self.width, sglReplyV2.totalHeight);
    [self addSubview:sglReplyV2];
    UIView *ling1 = [[UIView alloc] init];
    ling1.frame = CGRectMake(0, sglReplyV2.frame.origin.y, FNScreenW-20, 0.5);
    ling1.backgroundColor = FNColor(200, 200, 200);
    [self addSubview:ling1];
    
    _totalHeight = sglReplyV2.height+sglReplyV2.frame.origin.y+FNNewsReplyMargin+40;
    
    if (replyArray.count == 2)return;
    FNNewsReplyItem *reply3 = replyArray[2][0];
    FNNewsSglReplyView *sglReplyV3 = [FNNewsSglReplyView sglReplyViewWithItem:reply3];
    sglReplyV3.frame = CGRectMake(0, sglReplyV2.height+sglReplyV2.frame.origin.y+FNNewsReplyMargin, self.width, sglReplyV3.totalHeight);
    [self addSubview:sglReplyV3];
    UIView *ling2 = [[UIView alloc] init];
    ling2.backgroundColor = FNColor(200, 200, 200);
    ling2.frame = CGRectMake(0, sglReplyV3.frame.origin.y, FNScreenW-20, 0.5);
    [self addSubview:ling2];
    
    _totalHeight = sglReplyV3.height+sglReplyV3.frame.origin.y+FNNewsReplyMargin+40;
}

@end
