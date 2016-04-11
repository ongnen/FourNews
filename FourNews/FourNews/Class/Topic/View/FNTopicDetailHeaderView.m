//
//  FNTopicDetailHeaderView.m
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicDetailHeaderView.h"
#import <UIImageView+WebCache.h>
#import "FNTopicDetailHeaderVBottomView.h"

@interface FNTopicDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *descL;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (nonatomic, weak) UIView *nameLine;
@property (nonatomic, weak) FNTopicDetailHeaderVBottomView *bottomV;

@end

@implementation FNTopicDetailHeaderView

- (FNTopicDetailHeaderVBottomView *)bottomV
{
    if (!_bottomV){
        FNTopicDetailHeaderVBottomView *bottomV = [[NSBundle mainBundle]loadNibNamed:@"FNTopicDetailHeaderVBottomView" owner:nil options:0].lastObject;
        [self addSubview:bottomV];
        _bottomV = bottomV;
    }
    return _bottomV;
    
}

- (UIView *)nameLine
{
    if (!_nameLine) {
        UIView *nameLine = [[UIView alloc]init];
        nameLine.backgroundColor = FNColor(150, 150, 150);
        [self.nameL addSubview:nameLine];
        _nameLine = nameLine;
    }
    return _nameLine;
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
    style.lineSpacing = 5.0;
    [descAttrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, listItem.alias.length)];
    headerV.descL.attributedText = descAttrStr;
    
    // 设置底部条
    
    NSString *mesStr = [NSString stringWithFormat:@"%@提问   %@回复  进行中",listItem.questionCount,listItem.answerCount];
    headerV.bottomV.messageL.textColor = FNColor(150, 150, 150);
    headerV.bottomV.messageL.font = [UIFont systemFontOfSize:12];
    headerV.bottomV.messageL.text = mesStr;
    
    return headerV;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bottomV.frame = CGRectMake(0, 138, FNScreenW, 30);
}

@end
