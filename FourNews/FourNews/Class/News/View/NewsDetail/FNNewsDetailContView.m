//
//  FNNewsDetailContView.m
//  FourNews
//
//  Created by xmg on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//


#import "FNNewsDetailContView.h"
#import "FNNewsDetailFrame.h"
#import <UIImageView+WebCache.h>
#import "FNLabel.h"
#import "FNNewsDealDetailItem.h"
#import "FNNewsDetailHotReplyView.h"
#import "FNNewsRelativeView.h"
#import "FNNewsGetReply.h"
#import "NSString+YJ.h"
#import "AppDelegate.h"
#import "FNNewsDetailShareView.h"
#import <OpenShareHeader.h>
#import "MBProgressHUD+MJ.h"


@interface FNNewsDetailContView ()

@property (nonatomic, weak) UILabel *titleL;

@property (nonatomic, weak) UILabel *pTimeL;

@property (nonatomic, weak) UILabel *sourceL;

@property (nonatomic, weak) UIView *contentL;

@property (nonatomic, weak) FNNewsDetailShareView *shareV;

@property (nonatomic, weak) UILabel *ecL;

@property (nonatomic, weak) FNNewsDetailHotReplyView *replyV;

@property (nonatomic, weak) FNNewsRelativeView *relativeV;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *imgVs;

@property (nonatomic, strong) NSMutableArray<UILabel *> *altLs;

@property (nonatomic, strong) NSMutableArray<NSValue *> *attrRanges;

@end

@implementation FNNewsDetailContView

- (NSMutableArray<UIImageView *> *)imgVs
{
    if (!_imgVs){
        self.imgVs = [[NSMutableArray alloc] init];
    }
    return _imgVs;
}

- (NSMutableArray<UILabel *> *)altLs
{
    if (!_altLs){
        self.altLs = [[NSMutableArray alloc] init];
    }
    return _altLs;
    
}

- (NSMutableArray<NSValue *> *)attrRanges
{
    if (!_attrRanges){
        self.attrRanges = [[NSMutableArray alloc] init];
    }
    return _attrRanges;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    // 创建view时加载所有控件
    [self setAllSubviews];
    return self;
}

/*
 创建view时加载所有控件
 */
- (void)setAllSubviews
{
    UILabel *titleL = [[UILabel alloc] init];
    titleL.numberOfLines = 0;
    titleL.font = [UIFont systemFontOfSize:FNNewsDetailContentTitleFont];
    self.titleL = titleL;
    [self addSubview:titleL];
    
    UILabel *pTimeL = [[UILabel alloc] init];
    pTimeL.font = [UIFont systemFontOfSize:FNNewsDetailPTimeFont];
    pTimeL.textColor = FNColor(155, 155, 155);
    self.pTimeL = pTimeL;
    [self addSubview:pTimeL];

    UILabel *sourceL = [[UILabel alloc] init];
    sourceL.font = [UIFont systemFontOfSize:FNNewsDetailSoureceFont];
    sourceL.textColor = FNColor(155, 155, 155);
    self.sourceL = sourceL;
    [self addSubview:sourceL];
    
    UIView *contentL = [[UIView alloc] init];
//    contentL.font = [UIFont systemFontOfSize:FNNewsDetailContentBodyFont];
    contentL.backgroundColor = FNColor(245, 245, 245);
    self.contentL = contentL;
    [self addSubview:contentL];
    
    UILabel *ecL = [[UILabel alloc] init];
    ecL.font = [UIFont systemFontOfSize:FNNewsDetailSoureceFont];
    ecL.textColor = FNColor(100, 100, 100);
    self.ecL = ecL;
    [self addSubview:ecL];

    FNNewsDetailShareView *shareV = [[NSBundle mainBundle] loadNibNamed:@"FNNewsDetailShareView" owner:nil options:0].lastObject;
    __weak typeof(self) weakSelf = self;
    shareV.sinaWeiboShareBlock = ^{
        [weakSelf shareTosinaWeibo];
    };
    shareV.weiCharShare = ^{
        [weakSelf shareToWeiChar];
    };
    shareV.qqZoneShare = ^{
        [weakSelf shareToQQZone];
    };
    self.shareV = shareV;
    [self addSubview:shareV];

    
    FNNewsDetailHotReplyView *replyV = [[NSBundle mainBundle] loadNibNamed:@"FNNewsDetailHotReplyView" owner:nil options:nil].lastObject;
    UITapGestureRecognizer *replyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replyViewClick)];
    [replyV addGestureRecognizer:replyTap];
    self.replyV = replyV;
    [self addSubview:replyV];

    
    FNNewsRelativeView *relativeV = [[NSBundle mainBundle] loadNibNamed:@"FNNewsRelativeView" owner:nil options:nil].lastObject;
    
    relativeV.keyWordBlock = ^(NSString *keyWord){
        [weakSelf lastKeyWordBtnClick:keyWord];
    };
    UITapGestureRecognizer *relativeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(relativeViewClick)];
    [relativeV addGestureRecognizer:relativeTap];
    self.relativeV = relativeV;
    [self addSubview:relativeV];
}
/*
 setter方法数据入口
 */
- (void)setDetailItem:(FNNewsDetailItem *)detailItem
{
    // 处理详情内容,删减不需要的对象
    _detailItem = [FNNewsDealDetailItem itemWithDetailitem:detailItem :^(NSMutableArray *array) {
        self.attrRanges = array;
    }];
    // 设置具体数据
    [self setDetailData];
    // 设置frame
    [self setDetailFrame];
}
/*
 设置详情页的详情内容数据
 */
- (void)setDetailData
{
    self.titleL.text = _detailItem.title;
    self.pTimeL.text = _detailItem.ptime;
    self.sourceL.text = _detailItem.source;
    self.ecL.text = _detailItem.ec;
    [self setTextCont];
    
    self.replyV.replyArray = _detailItem.replys;
    if (_detailItem.relative_sys.count!=0) {
        self.relativeV.detailItem = _detailItem;
    }
}

- (void)setTextCont{
    int imgIndex = 0;
    NSArray *frameArray = [[FNNewsDetailFrame alloc] getContFrameWith:_detailItem :_detailItem.contArray];
    for (int i = 0; i<_detailItem.contArray.count; i++) {
        if ([_detailItem.contArray[i] isKindOfClass:[NSString class]]) {
            NSString *body = _detailItem.contArray[i];
            UITextView *textV = [[UITextView alloc] init];
            textV.editable = NO;
            textV.text = body;
            [self.contentL addSubview:textV];
//            textV.font = [UIFont systemFontOfSize:FNNewsDetailContentBodyFont];
//            textV.textColor = FNColor(100, 100, 100);
            textV.backgroundColor = FNColor(245, 245, 245);
            textV.frame = [frameArray[i] CGRectValue];
            
            NSMutableArray *rangeArray = [NSMutableArray array];
            while ([body containsString:@"<b>"] || [body containsString:@"<strong>"]) {
                NSRange rangeFront;
                NSInteger locFront;
                NSRange rangeBack;
                NSInteger locBack;
                NSRange range;
                if ([body containsString:@"<b>"]) {
                    rangeFront = [body rangeOfString:@"<b>"];
                    locFront = rangeFront.location + 3;
                    rangeBack = [body rangeOfString:@"</b>"];
                    locBack = rangeBack.location;
                    range = NSMakeRange(locFront-3, locBack-locFront);
                } else {
                    rangeFront = [body rangeOfString:@"<strong>"];
                    locFront = rangeFront.location + 8;
                    rangeBack = [body rangeOfString:@"</strong>"];
                    locBack = rangeBack.location;
                    range = NSMakeRange(locFront-8, locBack-locFront);
                }
                
                body = [body stringByReplacingCharactersInRange:rangeBack withString:@""];
                body = [body stringByReplacingCharactersInRange:rangeFront withString:@""];
                
                [rangeArray addObject:[NSValue valueWithRange:range]];
                
                
            }
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            // 两端对齐
            style.alignment = NSTextAlignmentJustified;
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:body];
            [attr addAttribute:NSForegroundColorAttributeName value:FNColor(100, 100, 100) range:NSMakeRange(0, body.length)];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FNNewsDetailContentBodyFont] range:NSMakeRange(0, body.length)];
            [attr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, body.length)];
            for (int i = 0; i<rangeArray.count; i++) {
                NSRange range = [rangeArray[i] rangeValue];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
            }
            
            textV.attributedText = attr;
        } else {
            UIImageView *ImgV = [[UIImageView alloc] init];
            [self.imgVs addObject:ImgV];
            [ImgV sd_setImageWithURL:[NSURL URLWithString:_detailItem.img[imgIndex][@"src"]] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
            
            UILabel *altL = [[UILabel alloc] init];
            [self.altLs addObject:altL];
            [altL setText:_detailItem.img[imgIndex][@"alt"]];
            altL.textColor = FNColor(100, 100, 100);
            altL.font = [UIFont systemFontOfSize:14];
            altL.numberOfLines = 0;
            
            [self.contentL addSubview:ImgV];
            [self.contentL addSubview:altL];
            CGRect imgF = [frameArray[i] CGRectValue];
            ImgV.frame = CGRectMake(0, imgF.origin.y, imgF.size.width, imgF.size.height-20);
            altL.frame = CGRectMake(0, CGRectGetMaxY(ImgV.frame), CGRectGetWidth(ImgV.frame), 20);
            imgIndex++;
        }
    }
}

/*
 动态设置所有图片的内容
 */
- (void)setPictures
{
    for (int i = 0; i<_detailItem.img.count; i++) {
        UIImageView *ImgV = [[UIImageView alloc] init];
        [self.imgVs addObject:ImgV];
        [ImgV sd_setImageWithURL:[NSURL URLWithString:_detailItem.img[i][@"src"]] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
        
        UILabel *altL = [[UILabel alloc] init];
        [self.altLs addObject:altL];
        [altL setText:_detailItem.img[i][@"alt"]];
        altL.textColor = FNColor(200, 200, 200);
        altL.font = [UIFont systemFontOfSize:14];
        altL.numberOfLines = 0;
        
        [self addSubview:ImgV];
        [self addSubview:altL];
    }
}

/*
 设置详情页的所有frame
 */
- (void)setDetailFrame
{
    // 获得frame
    FNNewsDetailFrame *contFrames = [[FNNewsDetailFrame alloc] init];
    contFrames.detailItem = _detailItem;
    // 设置frame
    self.titleL.frame = contFrames.titleF;
    self.pTimeL.frame = contFrames.pTimeF;
    self.sourceL.frame = contFrames.sourceF;
//    [self setPictureFrames:contFrames];
    self.contentL.frame = contFrames.contentF;
    self.ecL.frame = contFrames.ecF;
    self.shareV.frame = contFrames.shareF;
    self.shareV.subviews.firstObject.frame = self.shareV.bounds;
    self.replyV.frame = contFrames.replyF;
    self.replyV.hidden = !contFrames.replyF.size.height;
    if (_detailItem.relative_sys.count == 0) {
        self.relativeV.hidden = YES;
    } else {
        self.relativeV.frame = contFrames.relativeF;
    }
        
    _totalHeight = contFrames.relativeF.origin.y + contFrames.relativeF.size.height;
}



#pragma mark TapGestureOfRelativeNew
- (void)relativeViewClick
{
    if (self.relativeBlock) {
        self.relativeBlock(_detailItem.relative_sys[0][@"id"]);
    }
}

- (void)replyViewClick
{
    if (self.relativeBlock) {
        self.replyBlock();
    }
    
}

- (void)lastKeyWordBtnClick:(NSString *)keyWord
{
    
    if (self.lastKeyWordBtnClick) {
        self.lastKeyWordBtnClick(keyWord);
    }
}

// 分享

- (void)shareTosinaWeibo
{
    OSMessage *message = [[OSMessage alloc] init];
    
    message.title = [NSString stringWithFormat:@"%@ %@",_detailItem.title,_detailItem.shareLink];
    
    [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
        [MBProgressHUD showSuccess:@"分享成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [MBProgressHUD showError:@"分享失败"];
    }];
}

- (void)shareToWeiChar
{
    OSMessage *message = [[OSMessage alloc] init];
    
    message.title = [NSString stringWithFormat:@"%@ %@",_detailItem.title,_detailItem.shareLink];
    [OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
        [MBProgressHUD showSuccess:@"分享成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [MBProgressHUD showError:@"分享失败"];
    }];
}

- (void)shareToQQZone
{
    OSMessage *message = [[OSMessage alloc] init];
    
    message.title = [NSString stringWithFormat:@"%@ %@",_detailItem.title,_detailItem.shareLink];
    [OpenShare shareToQQZone:message Success:^(OSMessage *message) {
        [MBProgressHUD showSuccess:@"分享成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [MBProgressHUD showError:@"分享失败"];
    }];
}

- (void)dealloc
{
}

@end
