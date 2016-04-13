//
//  FNTopicDetailCell.m
//  FourNews
//
//  Created by xmg on 16/4/12.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicDetailCell.h"
#import "FNTopicDetailCellQuesView.h"
#import "FNTopicDetailCellAnsView.h"
#import "NSString+YJ.h"

@interface FNTopicDetailCell ()
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@property (nonatomic, weak) FNTopicDetailCellQuesView *quesView;
@property (nonatomic, weak) FNTopicDetailCellAnsView *ansView;
@property (nonatomic, weak) UIView *marginV;
@property (nonatomic, weak) UIView *separeteLine;

@end

@implementation FNTopicDetailCell

- (void)awakeFromNib
{
    UIView *separeteLine = [[UIView alloc] init];
    separeteLine.backgroundColor = FNCommonColor;
    [self addSubview:separeteLine];
    _separeteLine = separeteLine;
    
    UIView *marginV = [[UIView alloc] init];
    marginV.backgroundColor = FNCommonColor;
    [self addSubview:marginV];
    _marginV = marginV;
}

- (UIView *)quesView
{
    if (!_quesView) {
        FNTopicDetailCellQuesView *quesView = [[NSBundle mainBundle] loadNibNamed:@"FNTopicDetailCellQuesView" owner:nil options:0].lastObject;
        [self addSubview:quesView];
        _quesView = quesView;
    }
    return _quesView;
}
- (UIView *)ansView
{
    if (!_ansView) {
        FNTopicDetailCellAnsView *ansView = [[NSBundle mainBundle] loadNibNamed:@"FNTopicDetailCellAnsView" owner:nil options:0].lastObject;
        [self addSubview:ansView];
        _ansView = ansView;
    }
    return _ansView;
}



- (void)setDetailItem:(FNTopicDetailItem *)detailItem
{
    _detailItem = detailItem;
    // 设置提问数据
    self.quesView.quesItem = detailItem.question;
    self.quesView.frame = CGRectMake(0, 0, FNScreenW, self.quesView.totalHeight);
    // 设置回答数据
    self.ansView.ansItem = detailItem.answer;
    self.ansView.frame = CGRectMake(0, self.quesView.totalHeight, FNScreenW, self.ansView.totalHeight);
    // 设置分割线与分隔View
    self.marginV.frame = CGRectMake(0, CGRectGetMaxY(self.ansView.frame)+50, FNScreenW, YJMargin);
    self.separeteLine.frame = CGRectMake(40, CGRectGetMaxY(self.quesView.frame)+YJMargin, FNScreenW-40-YJMargin, 0.5);
    [self bringSubviewToFront:self.separeteLine];
    
    [self.repostButton setTitle:detailItem.answer.replyCount forState:UIControlStateNormal];
    [self.zanButton setTitle:detailItem.answer.supportCount forState:UIControlStateNormal];
}

+ (CGFloat)totalHeightWithItem:(FNTopicDetailItem *)detailItem
{
    FNTopicDetailCellQuesView *quesView = [[NSBundle mainBundle] loadNibNamed:@"FNTopicDetailCellQuesView" owner:nil options:0].lastObject;
    quesView.quesItem = detailItem.question;
    
    FNTopicDetailCellAnsView *ansView = [[NSBundle mainBundle] loadNibNamed:@"FNTopicDetailCellAnsView" owner:nil options:0].lastObject;
    ansView.ansItem = detailItem.answer;
    
    
    return quesView.totalHeight+ansView.totalHeight+50+YJMargin;
}

@end
