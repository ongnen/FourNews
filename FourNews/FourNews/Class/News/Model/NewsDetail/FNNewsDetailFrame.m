//
//  FNNewsDetailFrame.m
//  FourNews
//
//  Created by xmg on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//


#import "FNNewsDetailContImgItem.h"
#import "FNNewsDetailFrame.h"
#import "FNNewsDetailHotReplyView.h"
#import "FNNewsRelativeView.h"

@implementation FNNewsDetailFrame

- (NSMutableArray *)pictureFs
{
    if (!_pictureFs){
        self.pictureFs = [[NSMutableArray alloc] init];
    }
    return _pictureFs;
}

- (NSMutableArray *)altFs
{
    if (!_altFs){
        self.altFs = [[NSMutableArray alloc] init];
    }
    return _altFs;
    
}

- (void)setDetailItem:(FNNewsDetailItem *)detailItem
{
    _detailItem = detailItem;
    // 标题
    CGFloat titleX = FNNewsDetailLeftBorder;
    CGFloat titleY = FNNewsDetailTopBorder;
    CGSize titleSize = [detailItem.title boundingRectWithSize:CGSizeMake(FNScreenW - 2*FNNewsDetailLeftBorder, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FNNewsDetailContentTitleFont]} context:nil].size;
    _titleF = (CGRect){titleX,titleY,titleSize};
    // 时间
    CGFloat pTimeX = FNNewsDetailLeftBorder;
    CGFloat pTimeY = FNNewsDetailLeftBorder + FNNewsDetailTopBorder + titleSize.height;
    CGSize pTimeSize = [detailItem.ptime sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FNNewsDetailPTimeFont]}];
    _pTimeF = (CGRect){pTimeX,pTimeY,pTimeSize};
    // 来源
    CGFloat sourceX = 2*FNNewsDetailLeftBorder + pTimeSize.width;
    CGFloat sourceY = pTimeY;
    CGSize sourceSize = [detailItem.source sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FNNewsDetailSoureceFont]}];
    _sourceF = (CGRect){sourceX,sourceY,sourceSize};
    
    // 文字内容加图片内容
    NSArray *frameArray = [self getContFrameWith:_detailItem :detailItem.contArray];
    CGFloat contentY = sourceY + sourceSize.height + 2*FNNewsDetailLeftBorder;
    CGFloat contentMaxY = CGRectGetMaxY([frameArray.lastObject CGRectValue]);
    _contentF = CGRectMake(FNNewsDetailLeftBorder, contentY, FNScreenW-2*FNNewsDetailLeftBorder, contentMaxY);
//    for (int i = 0; i<_detailItem.img.count; i++) {
//        if (_detailItem.img[i][@"pixel"]) {
//            NSString *strSz = _detailItem.img[i][@"pixel"];
//            NSInteger loc = [strSz rangeOfString:@"*"].location;
//            NSString *strW = [strSz substringToIndex:loc];
//            NSString *strH = [strSz substringFromIndex:loc+1];
//            NSInteger imgH = [strH intValue] * ((FNScreenW-2*FNNewsDetailLeftBorder)/[strW intValue]);
//            CGFloat topImgX = FNNewsDetailLeftBorder;
//            CGFloat topImgY = pTimeY + pTimeSize.height + FNNewsDetailLeftBorder + _totalPicH;
//            CGFloat topImgW = FNScreenW - 2*FNNewsDetailLeftBorder;
//            CGFloat topImgH = imgH;
//            CGRect imgF = CGRectMake(topImgX, topImgY, topImgW, topImgH);
//            [self.pictureFs addObject:[NSValue valueWithCGRect:imgF]];
//            
//            NSString *altStr = _detailItem.img[i][@"alt"];
//            CGSize altSize = [altStr boundingRectWithSize:CGSizeMake(FNScreenW - 2*FNNewsDetailLeftBorder, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FNNewsDetailImgAltFont]} context:nil].size;
//            CGRect altF = (CGRect){FNNewsDetailLeftBorder,topImgY + topImgH + FNNewsDetailAltBorder,altSize};
//            [self.altFs addObject:[NSValue valueWithCGRect:altF]];
//            
//            _totalPicH += (topImgH + altF.size.height + 2 * FNNewsDetailLeftBorder);
//        } else {
//        }
//    }
//
//    CGFloat contentY = sourceY + sourceSize.height + 2*FNNewsDetailLeftBorder;
//    
//    CGSize size1 = [detailItem.body boundingRectWithSize:CGSizeMake(FNScreenW - 2*FNNewsDetailLeftBorder, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FNNewsDetailContentBodyFont]} context:nil].size;
//    CGSize size2 = [detailItem.body boundingRectWithSize:CGSizeMake(FNScreenW - 2*FNNewsDetailLeftBorder, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FNNewsDetailContentBodyFont]} context:nil].size;
//    NSInteger numb = (int)size1.height/size2.height+1;
//    _contentF = (CGRect){FNNewsDetailLeftBorder,contentY,size1.width,numb*23 + _totalPicH};// *1.2是暂时性调整
    
    // 责任编辑
    CGSize ecSize = [_detailItem.ec sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FNNewsDetailSoureceFont]}];
    CGFloat ecX = FNScreenW - ecSize.width - FNNewsDetailLeftBorder;
    CGFloat ecY = _contentF.origin.y + _contentF.size.height + FNNewsDetailTopBorder;
    _ecF = (CGRect){ecX,ecY,ecSize};
    
    // 分享
    CGFloat shareX = 0;
    CGFloat shareY = _ecF.origin.y+_ecF.size.height+FNNewsDetailTopBorder;
    CGFloat shareW = FNScreenW;
    CGFloat shareH = FNScreenW * 180/750;
    _shareF = CGRectMake(shareX, shareY, shareW, shareH);
    
    // 评论
    CGFloat replyX = FNNewsDetailLeftBorder;
    CGFloat replyY = _shareF.origin.y + _shareF.size.height + FNNewsDetailTopBorder;
    CGFloat replyW = FNScreenW - 2*FNNewsDetailLeftBorder;
    CGFloat replyH = 0;
    if (_detailItem.replys.count !=0) {
        replyH = [FNNewsDetailHotReplyView totalHeightWithReplyArray:_detailItem.replys];
    }
    _replyF = CGRectMake(replyX, replyY, replyW, replyH);
    
    // 相关新闻
    CGFloat relativeX = FNNewsDetailLeftBorder;
    CGFloat relativeY = _replyF.origin.y + _replyF.size.height + FNNewsDetailTopBorder;
    CGFloat relativeW = FNScreenW - 2*FNNewsDetailLeftBorder;
    CGFloat relativeH = 0;
    if (_detailItem.relative_sys.count!=0) {
        relativeH = [FNNewsRelativeView totalHeightWithItem:_detailItem];
    }
    _relativeF = CGRectMake(relativeX, relativeY, relativeW, relativeH);

}

- (NSMutableArray *)contFrameArray
{
    if (!_contFrameArray) {
        NSMutableArray *contFrameArray = [NSMutableArray array];
        _contFrameArray = contFrameArray;
    }
    return _contFrameArray;
}

- (NSArray *)getContFrameWith:(FNNewsDetailItem *)detailItem :(NSArray *)contArray
{
    _detailItem = detailItem;
    NSInteger imgIndex = 0;
    for (int i = 0; i<contArray.count; i++) {
        if ([contArray[i] isKindOfClass:[NSString class]]) {
            UITextView *textV = [[UITextView alloc] init];
            textV.bounds = CGRectMake(0, 0, FNScreenW - 2*FNNewsDetailLeftBorder, 10);
            textV.text = contArray[i];
            textV.font = [UIFont systemFontOfSize:FNNewsDetailContentBodyFont];
            UIView *TextContainerView = textV.subviews[0];
            textV.bounds = TextContainerView.bounds;
            CGRect textF = CGRectMake(0, 0, FNScreenW - 2*FNNewsDetailLeftBorder, TextContainerView.bounds.size.height);
            
            if (self.contFrameArray.lastObject) {
                textF = CGRectMake(0, CGRectGetMaxY([_contFrameArray.lastObject CGRectValue]), FNScreenW - 2*FNNewsDetailLeftBorder, TextContainerView.bounds.size.height);
            }
            id objc = [NSValue valueWithCGRect:textF];
            [_contFrameArray addObject:objc];
        } else {
            if (_detailItem.img[imgIndex][@"pixel"]) {
                NSString *strSz = _detailItem.img[imgIndex][@"pixel"];
                NSInteger loc = [strSz rangeOfString:@"*"].location;
                NSString *strW = [strSz substringToIndex:loc];
                NSString *strH = [strSz substringFromIndex:loc+1];
                CGFloat imgH = [strH intValue] * ((FNScreenW-2*FNNewsDetailLeftBorder)/[strW intValue]);
                CGRect imgF = CGRectMake(0, 0, FNScreenW - 2*FNNewsDetailLeftBorder, imgH);
                if (self.contFrameArray.lastObject) {
                    imgF = CGRectMake(0, CGRectGetMaxY([_contFrameArray.lastObject CGRectValue]), FNScreenW - 2*FNNewsDetailLeftBorder, imgH+20);
                }
                id objc = [NSValue valueWithCGRect:imgF];
                [_contFrameArray addObject:objc];
            }
            imgIndex++;
        }
    }
    
    return _contFrameArray;
}

@end
