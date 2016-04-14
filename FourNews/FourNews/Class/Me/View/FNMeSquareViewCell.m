
//
//  FNMeSquareViewCell.m
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNMeSquareViewCell.h"
#import <UIImageView+WebCache.h>

@interface FNMeSquareViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@end

@implementation FNMeSquareViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setItem:(FNMeSquareItem *)item
{
    _item = item;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_item.icon]];
    self.nameL.text = _item.name;
}

@end