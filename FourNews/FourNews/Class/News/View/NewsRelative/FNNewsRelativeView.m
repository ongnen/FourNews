//
//  FNNewsRelativeView.m
//  FourNews
//
//  Created by xmg on 16/4/4.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsRelativeView.h"
#import <MJExtension.h>
#import "FNNewsKeyButton.h"
#import <UIImageView+WebCache.h>
#define FNNewsReplyBorder3 3
#define FNNewsReplyBorder5 5
#define FNNewsReplyBorder10 10
#define FNNewsReplyFont12 [UIFont systemFontOfSize:12]
#define FNNewsReplyFont14 [UIFont systemFontOfSize:14]
#define FNNewsReplyFont16 [UIFont systemFontOfSize:16]
#define FNNewsReplyColor150 FNColor(150, 150, 150)
#define FNNewsReplyColor180 FNColor(180, 180, 180)
#define FNNewsReplyColor200 FNColor(200, 200, 200)
#define FNNewsReplyColor220 FNColor(220, 220, 220)

@interface FNNewsRelativeView ()

@property (nonatomic, weak) FNNewsKeyButton *keyButton1;
@property (nonatomic, weak) FNNewsKeyButton *keyButton2;
@property (nonatomic, weak) FNNewsKeyButton *keyButton3;
@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, weak) UILabel *titleL;
@property (nonatomic, weak) UILabel *sourceL;
@property (nonatomic, weak) UILabel *ptimeL;

@property (nonatomic, strong) FNNewsRelativeItem *relativeItem;


@end

@implementation FNNewsRelativeView

- (void)setDetailItem:(FNNewsDetailItem *)detailItem
{
    _detailItem = detailItem;
    
    _relativeItem = [FNNewsRelativeItem mj_objectWithKeyValues:detailItem.relative_sys[0]];
    
    [self setAllSubviews];
    
    [self setSubviewsFrame];
}
+ (CGFloat)totalHeightWithItem:(FNNewsDetailItem *)detailItem
{
    FNNewsRelativeView *view = [[FNNewsRelativeView alloc] init];
    view.detailItem = detailItem;
    [view setSubviewsFrame];
    return view.totalHeight;
}

- (void)setKeyBtnWithButton:(FNNewsKeyButton *)btn :(NSString *)title
{
    [btn setImage:[UIImage resizableImage:@"choose_city_normal"] forState:UIControlStateNormal];
    [btn setImage:[UIImage resizableImage:@"choose_city_highlight"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = FNNewsReplyFont14;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor: FNColorAlpha(0, 0, 200, 0.7) forState:UIControlStateNormal];
    [self addSubview:btn];
}

- (void)keyWordBtnClick:(FNNewsKeyButton *)Btn
{
    
    if (self.keyWordBlock) {
        self.keyWordBlock(Btn.titleLabel.text);
    }
}

- (void)setAllSubviews
{
    FNNewsKeyButton *keyButton1 = [[FNNewsKeyButton alloc] init];
    [self setKeyBtnWithButton:keyButton1 :_detailItem.keyword_search[0][@"word"]];
    [keyButton1 addTarget:self action:@selector(keyWordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.keyButton1 = keyButton1;
    
    FNNewsKeyButton *keyButton2 = [[FNNewsKeyButton alloc] init];
    [self setKeyBtnWithButton:keyButton2 :_detailItem.keyword_search[1][@"word"]];
    [keyButton2 addTarget:self action:@selector(keyWordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.keyButton2 = keyButton2;
    
    FNNewsKeyButton *keyButton3 = [[FNNewsKeyButton alloc] init];
    [self setKeyBtnWithButton:keyButton3 :_detailItem.keyword_search[2][@"word"]];
    [keyButton3 addTarget:self action:@selector(keyWordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.keyButton3 = keyButton3;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:_relativeItem.imgsrc] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    [self addSubview:imageV];
    self.imageV = imageV;
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.text = _relativeItem.title;
    titleL.font = FNNewsReplyFont14;
    titleL.textColor = [UIColor blackColor];
    titleL.numberOfLines = 0;
    [self addSubview:titleL];
    self.titleL = titleL;
    
    UILabel *sourceL = [[UILabel alloc] init];
    sourceL.text = _relativeItem.source;
    sourceL.font = FNNewsReplyFont12;
    sourceL.textColor = FNNewsReplyColor150;
    [self addSubview:sourceL];
    self.sourceL = sourceL;
    
    UILabel *ptimeL = [[UILabel alloc] init];
    ptimeL.text = _relativeItem.ptime;
    ptimeL.font = FNNewsReplyFont12;
    ptimeL.textColor = FNNewsReplyColor150;
    [self addSubview:ptimeL];
    self.ptimeL = ptimeL;
}

- (void)setSubviewsFrame
{
    CGFloat keyBtn1X = 10;
    CGFloat keyBtn1Y = 40;
    CGSize keyBtn1Size = [_detailItem.keyword_search[0][@"word"] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    self.keyButton1.frame = (CGRect){keyBtn1X,keyBtn1Y,keyBtn1Size};
    CGFloat keyBtn2X = keyBtn1X+keyBtn1Size.width+FNNewsReplyBorder10;
    CGFloat keyBtn2Y = 40;
    CGSize keyBtn2Size = [_detailItem.keyword_search[1][@"word"] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    self.keyButton2.frame = (CGRect){keyBtn2X,keyBtn2Y,keyBtn2Size};
    CGFloat keyBtn3X = keyBtn2X+keyBtn2Size.width+FNNewsReplyBorder10;
    CGFloat keyBtn3Y = 40;
    CGSize keyBtn3Size = [_detailItem.keyword_search[2][@"word"] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    self.keyButton3.frame = (CGRect){keyBtn3X,keyBtn3Y,keyBtn3Size};
    
    CGFloat imgX = 10;
    CGFloat imgY = keyBtn1Y+keyBtn1Size.height+FNNewsReplyBorder10;
    CGFloat imgW = 70;
    CGFloat imgH = 60;
    self.imageV.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat titleX = imgX+imgW+FNNewsReplyBorder10;
    CGFloat tilleY = imgY-FNNewsReplyBorder5;
    CGSize titleSize = [_relativeItem.title boundingRectWithSize:CGSizeMake(FNScreenW-6*FNNewsReplyBorder10-imgW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FNNewsReplyFont16} context:nil].size;
    self.titleL.frame = (CGRect){titleX,tilleY,titleSize};
    
    
    CGSize sourceSize = [_relativeItem.source sizeWithAttributes:@{NSFontAttributeName:FNNewsReplyFont12}];
    CGFloat sourceX = titleX;
    CGFloat sourceY = imgY+imgH-sourceSize.height;
    self.sourceL.frame = (CGRect){sourceX,sourceY,sourceSize};
    
    CGFloat ptimeX = sourceX+sourceSize.width+FNNewsReplyBorder10;
    CGFloat ptimeY = sourceY;
    CGSize ptimeSize = [_relativeItem.ptime sizeWithAttributes:@{NSFontAttributeName:FNNewsReplyFont12}];
    self.ptimeL.frame = (CGRect){ptimeX,ptimeY,ptimeSize};
    
    _totalHeight = imgY+imgH+FNNewsReplyBorder10;
    
}

@end
