//
//  FNNewsThrImgCell.m
//  FourNews
//
//  Created by xmg on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsThrImgCell.h"
#import <UIImageView+WebCache.h>

@interface FNNewsThrImgCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV1;
@property (weak, nonatomic) IBOutlet UIImageView *imageV2;
@property (weak, nonatomic) IBOutlet UIImageView *imageV3;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FNNewsThrImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)setContItem:(FNNewsListItem *)contItem
{
    _contItem = contItem;
    
    [self.imageV1 sd_setImageWithURL:[NSURL URLWithString:contItem.imgsrc] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    
    [self.imageV2 sd_setImageWithURL:[NSURL URLWithString:contItem.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    
    [self.imageV3 sd_setImageWithURL:[NSURL URLWithString:contItem.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    
    self.titleLabel.text = contItem.title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageV1.contentMode = UIViewContentModeScaleToFill;
    self.imageV2.contentMode = UIViewContentModeScaleToFill;
    self.imageV3.contentMode = UIViewContentModeScaleToFill;
}

@end
