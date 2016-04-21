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

@property (nonatomic, weak) FNLabel *contentL;

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
    
    FNLabel *contentL = [[FNLabel alloc] init];
    contentL.font = [UIFont systemFontOfSize:FNNewsDetailContentBodyFont];
    contentL.textColor = FNColor(100, 100, 100);
    self.contentL = contentL;
    [self addSubview:contentL];
    
    UILabel *ecL = [[UILabel alloc] init];
    ecL.font = [UIFont systemFontOfSize:FNNewsDetailSoureceFont];
    ecL.textColor = FNColor(100, 100, 100);
    self.ecL = ecL;
    [self addSubview:ecL];

    FNNewsDetailShareView *shareV = [[NSBundle mainBundle] loadNibNamed:@"FNNewsDetailShareView" owner:nil options:0].lastObject;
    shareV.sinaWeiboShareBlock = ^{
        [self shareTosinaWeibo];
    };
    shareV.weiCharShare = ^{
        [self shareToWeiChar];
    };
    shareV.qqZoneShare = ^{
        [self shareToQQZone];
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
        [self lastKeyWordBtnClick:keyWord];
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
    // 设置body内容的格式
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:_detailItem.body];
    for (int i = 0; i<self.attrRanges.count; i++) {
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FNNewsDetailContentBodyFont] range:[self.attrRanges[i] rangeValue]];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[self.attrRanges[i] rangeValue]];
    }
    self.contentL.string = attr;
    self.replyV.replyArray = _detailItem.replys;
    if (_detailItem.relative_sys.count!=0) {
        self.relativeV.detailItem = _detailItem;
    }
    // 设置所有图片
    [self setPictures];
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
    [self setPictureFrames:contFrames];
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

/*
 动态设置所有图片的frame
 */
- (void)setPictureFrames:(FNNewsDetailFrame *)frame
{
    NSInteger frameIndex = -1;
    for (int i = 0; i<_detailItem.img.count; i++) {
        if (_detailItem.img[i][@"pixel"]) {
            frameIndex++;
            CGRect imgF = [frame.pictureFs[frameIndex] CGRectValue];
            self.imgVs[i].frame = imgF;
            
            CGRect altF = [frame.altFs[frameIndex] CGRectValue];
            self.altLs[i].frame = altF;
        } else {
            frameIndex--;
        }
    }
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



@end
