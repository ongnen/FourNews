//
//  FNReadListThreeImgCell.m
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNReadListThreeImgCell.h"
#import <UIImageView+WebCache.h>

@interface FNReadListThreeImgCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *imgOneV;
@property (weak, nonatomic) IBOutlet UIImageView *imgTwoV;
@property (weak, nonatomic) IBOutlet UIImageView *imgThreeV;
@property (weak, nonatomic) IBOutlet UILabel *sourceL;
@property (weak, nonatomic) IBOutlet UIButton *unlikeButton;

@end

@implementation FNReadListThreeImgCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(FNReadListItem *)item
{
    _item = item;
    
    self.titleL.text = item.title;
    
    [self.imgOneV sd_setImageWithURL:[NSURL URLWithString:item.imgsrc] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    
    [self.imgTwoV sd_setImageWithURL:[NSURL URLWithString:item.imgnewextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    
    [self.imgThreeV sd_setImageWithURL:[NSURL URLWithString:item.imgnewextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    
    self.sourceL.text = item.source;
    
}

@end
