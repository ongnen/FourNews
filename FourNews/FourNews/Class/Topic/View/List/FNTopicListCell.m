
//
//  FNTopicListCell.m
//  FourNews
//
//  Created by xmg on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicListCell.h"
#import <UIImageView+WebCache.h>

@interface FNTopicListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
// 摘要
@property (weak, nonatomic) IBOutlet UILabel *digestL;
@property (weak, nonatomic) IBOutlet UILabel *messageL;

@property (weak, nonatomic) IBOutlet UIView *focuView;

@property (weak, nonatomic) UIView *nameLine;

@end

@implementation FNTopicListCell

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

- (void)awakeFromNib {
    
}

- (void)setListItem:(FNTopicListItem *)listItem
{
    _listItem = listItem;
    
    [self setupIconVAndImageV];
    
    [self setupNameString];
    
    [self setupDigest];
    
    [self setupBottonMessage];
    
    [self setupFocuView];
}
#pragma mark - 设置头像和大图
- (void)setupIconVAndImageV
{
    [self.iconV sd_setImageWithURL:[NSURL URLWithString:_listItem.headpicurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconV.image = [UIImage circleImageWithBorder:3 color:[UIColor whiteColor] image:image];
    }];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:_listItem.picurl] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
}
#pragma mark - 设置顶部文字
- (void)setupNameString
{
    NSString *nameStr = [NSString stringWithFormat:@"%@   %@",_listItem.name,_listItem.title];
    NSMutableAttributedString *nameAttrString = [[NSMutableAttributedString alloc] initWithString:nameStr];
    [nameAttrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[nameStr rangeOfString:_listItem.name]];
    [nameAttrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:[nameStr rangeOfString:_listItem.title]];
    [nameAttrString addAttribute:NSForegroundColorAttributeName value:FNColor(150, 150, 150) range:[nameStr rangeOfString:_listItem.title]];
    
    CGFloat lineX = [[NSString stringWithFormat:@"%@ ",_listItem.name] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width;
    self.nameLine.frame = CGRectMake(lineX+FNCompensate(3), FNCompensate(9), 0.5, 11);
    
    self.nameL.attributedText = nameAttrString;
}

#pragma mark - 设置大图下方描述

- (void)setupDigest
{
    NSMutableAttributedString *digestAttr = [[NSMutableAttributedString alloc] initWithString:_listItem.alias];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5.0;
    [digestAttr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, _listItem.alias.length)];
    [digestAttr addAttribute:NSKernAttributeName value:@(1) range:NSMakeRange(0, _listItem.alias.length)];
    self.digestL.attributedText = digestAttr;
    self.digestL.font = [UIFont systemFontOfSize:16];
    self.digestL.numberOfLines = 0;
}

#pragma mark - 设置底部文字信息
- (void)setupBottonMessage
{
    NSString *concernCountStr = [NSString stringWithFormat:@"%d",[_listItem.concernCount intValue]];
    if ([_listItem.concernCount intValue]>9999) {
        concernCountStr =  [NSString stringWithFormat:@"%0.1f万",[_listItem.concernCount intValue]/10000.0];
    }
    NSString *questionCountStr = [NSString stringWithFormat:@"%d",[_listItem.questionCount intValue]];
    if ([_listItem.questionCount intValue]>9999) {
        questionCountStr =  [NSString stringWithFormat:@"%0.1f万",[_listItem.questionCount intValue]/10000.0];
    }
    
    NSString *messageStr = [NSString stringWithFormat:@"%@   %@ 关注   %@ 提问",_listItem.classification,concernCountStr,questionCountStr];
    
    NSMutableAttributedString *messageAttrStr = [[NSMutableAttributedString alloc] initWithString:messageStr];
    [messageAttrStr addAttribute:NSForegroundColorAttributeName value:FNColor(30, 150, 255) range:[messageStr rangeOfString:_listItem.classification]];
    self.messageL.textColor = FNColor(150, 150, 150);
    self.messageL.font = [UIFont systemFontOfSize:11];
    
    self.messageL.attributedText = messageAttrStr;
}

#pragma mark - 设置关注view

- (void)setupFocuView
{
    self.focuView.layer.cornerRadius = 15;
    self.focuView.clipsToBounds = YES;
}

@end
