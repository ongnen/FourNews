//
//  FNLabel.h
//  FNLabelDemo
//
//  Created by ZYJ on 12-11-8.
//  Copyright (c) 2012年 ZYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNLabel : UIView


@property (nonatomic, strong) NSMutableAttributedString* string;
@property (nonatomic, strong) NSString* text;

@property (nonatomic, strong) UIFont* font;
@property (nonatomic, strong) UIColor* textColor;

@end
