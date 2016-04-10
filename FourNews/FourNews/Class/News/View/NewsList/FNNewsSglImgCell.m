//
//  FNNewsSglImgCell.m
//  FourNews
//
//  Created by xmg on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsSglImgCell.h"
#import <UIImageView+WebCache.h>
#import "FNNewsReplyButton.h"

@interface FNNewsSglImgCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (nonatomic, strong) FNNewsReplyButton *replyButton;

@end

@implementation FNNewsSglImgCell

- (FNNewsReplyButton *)replyButton
{
    if (!_replyButton){
        _replyButton = [[FNNewsReplyButton alloc] init];
    }
    return _replyButton;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)setContItem:(FNNewsListItem *)contItem
{
    _contItem = contItem;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:contItem.imgsrc] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    
    self.titleL.text = contItem.title;
    self.digestLabel.text = [NSString stringWithFormat:@"%@",contItem.digest];
    
    [self setupReplyBtn];
}

- (void)setupReplyBtn
{
    
    NSString *replyStr = [NSString stringWithFormat:@"%ld评论",_contItem.replyCount];
    if (_contItem.replyCount>9999) {
        replyStr = [NSString stringWithFormat:@"%.1lf万评论",_contItem.replyCount/10000.0];
    }
    
    [self.replyButton setImage:[UIImage resizableImage:@"night_contentcell_comment_border"] forState:UIControlStateNormal];
    [self.replyButton setTitle:replyStr forState:UIControlStateNormal];
    [self.replyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.replyButton.titleLabel.font = [UIFont systemFontOfSize:8];
    
    
    CGSize replyStrSize = [replyStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    
    CGFloat replyBtnX = FNScreenW - replyStrSize.width - 10;
    CGFloat replyBtnY = self.contentView.frame.size.height - replyStrSize.height;
    
    self.replyButton.frame = CGRectMake(replyBtnX, replyBtnY, replyStrSize.width,replyStrSize.height);
    [self.contentView addSubview:self.replyButton];
    
    // 控制label文字完美适应buttonmn的代码
    
//    if (_contItem.replyCount<10)  return;
//    if (_contItem.replyCount<100) {
//        self.replyButton.width-=2;
//        return;
//    }
//    if (_contItem.replyCount<1000 | _contItem.replyCount>=10000) {
//        self.replyButton.width-=4;
//        return;
//    }
//    if (_contItem.replyCount<10000) {
//        self.replyButton.width-=7;
//        return;
//    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!self.contentView) return;
//    self.digestLabel.text = [NSString stringWithFormat:@"%@ \n \n",self.digestLabel.text];
    self.digestLabel.font = [UIFont systemFontOfSize:14];
    self.digestLabel.textColor = FNColor(155, 155, 155);
    self.digestLabel.numberOfLines = 0;
    
    
}

@end
