//
//  FNTopicDetailCellQuesView.m
//  FourNews
//
//  Created by xmg on 16/4/12.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicDetailCellQuesView.h"
#import <UIImageView+WebCache.h>

@interface FNTopicDetailCellQuesView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *quesL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quesHeightContraint;

@end

@implementation FNTopicDetailCellQuesView

+ (instancetype)quesViewWithItem:(FNTopicQuesItem *)quesItem
{
    FNTopicDetailCellQuesView *quesView = [[NSBundle mainBundle] loadNibNamed:@"FNTopicDetailCellQuesView" owner:nil options:0].lastObject;
    // 设置头像
    quesView.iconImgV.layer.cornerRadius = 15;
    quesView.iconImgV.clipsToBounds = YES;
    [quesView.iconImgV sd_setImageWithURL:[NSURL URLWithString:quesItem.userHeadPicUrl] placeholderImage:[UIImage imageNamed:@"tabbar_icon_me_highlight"]];
    
    // 设置nameL
    quesView.nameL.text = quesItem.userName;
    quesView.nameL.font = [UIFont systemFontOfSize:14];
    quesView.nameL.textColor = FNColor(150, 150, 150);
    
    // 设置quesL
    quesView.quesL.text = quesItem.content;
    quesView.quesL.font = [UIFont systemFontOfSize:16];
    quesView.quesL.textColor = FNColor(150, 150, 150);
    quesView.quesL.numberOfLines = 0;
    CGFloat quesH = [quesItem.content boundingRectWithSize:CGSizeMake(FNScreenW-48-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    quesView.quesHeightContraint.constant = quesH;
    
    quesView.totalHeight = 55+quesH;
    
    return quesView;
}

- (void)setQuesItem:(FNTopicQuesItem *)quesItem
{
    _quesItem = quesItem;
    
    // 设置头像
    self.iconImgV.layer.cornerRadius = 15;
    self.iconImgV.clipsToBounds = YES;
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:quesItem.userHeadPicUrl]];
    
    // 设置nameL
    self.nameL.text = quesItem.userName;
    self.nameL.font = [UIFont systemFontOfSize:14];
    self.nameL.textColor = FNColor(150, 150, 150);
    
    // 设置quesL
    self.quesL.text = quesItem.content;
    self.quesL.font = [UIFont systemFontOfSize:16];
    self.quesL.textColor = FNColor(150, 150, 150);
    self.quesL.numberOfLines = 0;
    CGFloat quesH = [quesItem.content boundingRectWithSize:CGSizeMake(FNScreenW-48-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    self.quesHeightContraint.constant = quesH;
}



@end
