//
//  FNTopicDetailHeaderVBottomView.m
//  FourNews
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicDetailHeaderVBottomView.h"

@interface FNTopicDetailHeaderVBottomView ()



@end

@implementation FNTopicDetailHeaderVBottomView

- (void)awakeFromNib
{
    self.backgroundColor = FNColor(225, 225, 225);
}
- (IBAction)newOrHotChange:(id)sender {
    if (self.segueBlock) {
        self.segueBlock();
    }
}

@end
