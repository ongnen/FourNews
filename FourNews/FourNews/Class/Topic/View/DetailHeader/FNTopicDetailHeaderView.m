//
//  FNTopicDetailHeaderView.m
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicDetailHeaderView.h"
#import <UIImageView+WebCache.h>
#define FNHeaderNormalH 153
#define FNHeaderDescLNorH 50

@interface FNTopicDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *descL;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (nonatomic, weak) UIView *nameLine;
@property (nonatomic, weak) UIView *quesPoint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeightConstraint;

@end

@implementation FNTopicDetailHeaderView

- (void)awakeFromNib
{
    FNTopicDetailHeaderVBottomView *bottomV = [[NSBundle mainBundle]loadNibNamed:@"FNTopicDetailHeaderVBottomView" owner:nil options:0].lastObject;
    bottomV.segueBlock = ^{
        if (self.bottonSegueBlock) {
            self.bottonSegueBlock();
        }
    };
    [self addSubview:bottomV];
    _bottomV = bottomV;
    
    UIView *nameLine = [[UIView alloc]init];
    nameLine.backgroundColor = FNColor(150, 150, 150);
    [self.nameL addSubview:nameLine];
    _nameLine = nameLine;
    
    UIView *quesPoint = [[UIView alloc]init];
    quesPoint.backgroundColor = FNColor(150, 150, 150);
    [self.bottomV.messageL addSubview:quesPoint];
    _quesPoint = quesPoint;
}

+ (instancetype)topicDetailHeaderViewWithListItem:(FNTopicListItem *)listItem
{
    FNTopicDetailHeaderView *headerV = [[NSBundle mainBundle] loadNibNamed:@"FNTopicDetailHeaderView" owner:nil options:0].lastObject;
    // 设置头像
    [headerV.iconImgV sd_setImageWithURL:[NSURL URLWithString:listItem.headpicurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        headerV.iconImgV.image = [UIImage circleImageWithBorder:2 color:FNColor(30, 150, 255) image:image];
    }];
    
    // 设置nameL
    NSString *nameStr = [NSString stringWithFormat:@"%@   %@",listItem.name,listItem.title];
    
    CGFloat lineX = [[NSString stringWithFormat:@"%@ ",listItem.name] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width;
    headerV.nameLine.frame = CGRectMake(lineX+FNCompensate(2), FNCompensate(5), 0.5, 11);
    headerV.nameL.text = nameStr;
    headerV.nameL.font = [UIFont systemFontOfSize:12];
    headerV.nameL.textColor = FNColor(150, 150, 150);
    
    // 设置介绍详情descL
    headerV.descL.numberOfLines = 0;
    headerV.descL.font = [UIFont systemFontOfSize:14];
    headerV.descL.textColor = FNColor(150, 150, 150);
    NSMutableAttributedString *descAttrStr = [[NSMutableAttributedString alloc] initWithString:listItem.descrip];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.lineSpacing = 4.0;
    [descAttrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, listItem.descrip.length)];
    headerV.descL.attributedText = descAttrStr;
    
    // 设置底部条
    
    NSString *mesStr = [NSString stringWithFormat:@"%@提问   %@回复  进行中",listItem.questionCount,listItem.answerCount];
    CGFloat pointX = [[NSString stringWithFormat:@"%@提问 ",listItem.questionCount] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width;
    headerV.quesPoint.frame = CGRectMake(pointX + FNCompensate(1), 15, 2, 2);
    headerV.bottomV.messageL.textColor = FNColor(150, 150, 150);
    headerV.bottomV.messageL.font = [UIFont systemFontOfSize:12];
    headerV.bottomV.messageL.text = mesStr;
    
    // 设置箭头点击
    [headerV.detailButton addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return headerV;
}

+ (void)detailBtnClick:(UIButton *)btn
{
    // 使按钮翻转
    btn.selected = !btn.isSelected;
    CGFloat descLH;
    // 拿到headerV
    FNTopicDetailHeaderView *headerV = (FNTopicDetailHeaderView *)btn.superview;
    if (btn.selected == NO) {
        // 重新设置约束
        descLH = FNHeaderDescLNorH;
        headerV.descHeightConstraint.constant = descLH;
        
    } else {
        // 重新设置约束
        descLH = [headerV.descL.text boundingRectWithSize:CGSizeMake(headerV.descL.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height+FNCompensate(30);
        headerV.descHeightConstraint.constant = descLH;
    }
    // 重新设置headerV的height
    headerV.height = descLH-FNHeaderDescLNorH+FNHeaderNormalH;
    
    if (headerV.detailBlock) {
        headerV.detailBlock(headerV);
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bottomV.frame = CGRectMake(0, CGRectGetMaxY(self.detailButton.frame), FNScreenW, 30);
    
}

@end
