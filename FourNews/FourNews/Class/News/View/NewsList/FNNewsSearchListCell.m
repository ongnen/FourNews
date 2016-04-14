//
//  FNNewsSearchListCell.m
//  FourNews
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsSearchListCell.h"
#import "NSString+YJ.h"

@interface FNNewsSearchListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@property (weak, nonatomic) IBOutlet UILabel *ptimeL;

@end

@implementation FNNewsSearchListCell


- (void)setItem:(FNNewsSearchWordItem *)item
{
    _item = item;
    _item.title = [_item.title stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
    _item.title = [_item.title stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
    self.titleL.text = item.title;
    self.ptimeL.text = [NSString dateStringWithString:_item.ptime :@"yyyy-MM-dd HH:mm:ss"];;
}


@end
