//
//  FNReadListSglImgCell.m
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNReadListSglImgCell.h"
#import <UIImageView+WebCache.h>

@interface FNReadListSglImgCell ()

@property (weak, nonatomic) IBOutlet UIImageView *sglImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *sourceL;
@property (weak, nonatomic) IBOutlet UIButton *unlikeButton;


@end

@implementation FNReadListSglImgCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(FNReadListItem *)item
{
    _item = item;
    
    [self.sglImgV sd_setImageWithURL:[NSURL URLWithString:item.imgsrc] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    
    self.titleL.text = item.title;
    
    self.sourceL.text = item.source;
}
@end
