//
//  FNNewsPhotoDescView.m
//  FourNews
//
//  Created by xmg on 16/4/6.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsPhotoDescView.h"

@interface FNNewsPhotoDescView ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *descL;

@end

@implementation FNNewsPhotoDescView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = FNColorAlpha(0, 0, 0, 0.5);
    self.titleL.textColor = [UIColor whiteColor];
    self.descL.textColor = [UIColor whiteColor];
    self.descL.numberOfLines = 0;
    self.descL.font = [UIFont systemFontOfSize:15];
    self.indexL.textColor = [UIColor whiteColor];
}

- (void)setDescItem:(FNNewsPhotoSetItem *)descItem
{
    self.titleL.text = descItem.setname;
    if (descItem.note != nil && ![descItem.note containsString:@"来源"]) {
        self.descL.text = descItem.note;
    } else{
        self.descL.text = descItem.imgtitle;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize descSize = [self.descL.text boundingRectWithSize:CGSizeMake(FNScreenW-16,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.descL.frame = CGRectMake(8, 36, descSize.width, descSize.height);
}

+ (CGFloat)heightWithPhotoSet:(NSArray *)photoSet
{
    CGFloat maxHeight = 0;
    for (FNNewsPhotoSetItem *item in photoSet) {
        NSString *contentStr;
        if (item.note != nil && ![item.note containsString:@"来源"]) {
            contentStr = item.note;
        } else{
            contentStr = item.imgtitle;
        }
        CGFloat height = [contentStr boundingRectWithSize:CGSizeMake(FNScreenW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        height>maxHeight? maxHeight=height : maxHeight;
    }
    
    maxHeight = maxHeight + 64;
    
    return maxHeight;
}

@end
