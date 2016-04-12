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

@interface FNTopicDetailCell ()

@property (nonatomic, weak) FNTopicDetailCellQuesView *quesView;
@property (nonatomic, weak) FNTopicDetailCellAnsView *ansView;
@end

@implementation FNTopicDetailCell

- (UIView *)quesView
{
    if (!_quesView) {
        FNTopicDetailCellQuesView *quesView = [FNTopicDetailCellQuesView quesViewWithItem:_detailItem.question];
        [self addSubview:quesView];
        _quesView = quesView;
    }
    return _quesView;
}
- (UIView *)ansView
{
    if (!_ansView) {
        FNTopicDetailCellAnsView *ansView = [FNTopicDetailCellAnsView ansViewWithItem:_detailItem.answer];
        [self addSubview:ansView];
        _ansView = ansView;
    }
    return _ansView;
}

- (void)setDetailItem:(FNTopicDetailItem *)detailItem
{
    _detailItem = detailItem;
    
    self.quesView.quesItem = detailItem.question;
    self.quesView.frame = CGRectMake(0, 0, FNScreenW, self.quesView.totalHeight);
    
    self.ansView.ansItem = detailItem.answer;
    self.ansView.frame = CGRectMake(0, self.quesView.totalHeight, FNScreenW, self.ansView.totalHeight);
    
}

+ (CGFloat)totalHeightWithItem:(FNTopicDetailItem *)detailItem
{
    FNTopicDetailCellQuesView *quesView = [FNTopicDetailCellQuesView quesViewWithItem:detailItem.question];
    quesView.frame = CGRectMake(0, 0, FNScreenW, quesView.totalHeight);
    
    FNTopicDetailCellAnsView *ansView = [FNTopicDetailCellAnsView ansViewWithItem:detailItem.answer];
    ansView.frame = CGRectMake(0, quesView.totalHeight, FNScreenW, ansView.totalHeight);
    
    return CGRectGetMaxY(ansView.frame)+50;
}

@end
