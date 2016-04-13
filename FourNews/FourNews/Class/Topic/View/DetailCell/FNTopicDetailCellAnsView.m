//
//  FNTopicDetailCellAnsView.m
//  FourNews
//
//  Created by xmg on 16/4/12.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicDetailCellAnsView.h"
#import <UIImageView+WebCache.h>

@interface FNTopicDetailCellAnsView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *ansL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ansHeightContraint;

@end

@implementation FNTopicDetailCellAnsView



- (void)setAnsItem:(FNTopicAnswerItem *)ansItem{
    _ansItem = ansItem;
    
    // 设置头像
    self.iconImgV.layer.cornerRadius = 15;
    self.iconImgV.clipsToBounds = YES;
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:ansItem.specialistHeadPicUrl]];
    
    // 设置nameL
    self.nameL.text = ansItem.specialistName;
    self.nameL.font = [UIFont systemFontOfSize:14];
    self.nameL.textColor = FNColor(150, 150, 150);
    
    // 设置quesL
    self.ansL.text = ansItem.content;
    self.ansL.font = [UIFont systemFontOfSize:16];
    CGFloat ansH = [ansItem.content boundingRectWithSize:CGSizeMake(FNScreenW-48-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height+FNCompensate(5);
    self.totalHeight = 55+ansH;
    self.ansHeightContraint.constant = ansH;
}

@end
