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
    CGSize titleSize = [detailItem.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FNNewsDetailContentTitleFont]}];
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
    for (int i = 0; i<_detailItem.img.count; i++) {
        if (_detailItem.img[i][@"pixel"]) {
            NSString *strSz = _detailItem.img[i][@"pixel"];
            NSInteger loc = [strSz rangeOfString:@"*"].location;
            NSString *strW = [strSz substringToIndex:loc];
            NSString *strH = [strSz substringFromIndex:loc+1];
            NSInteger imgH = [strH intValue] * ((FNScreenW-2*FNNewsDetailLeftBorder)/[strW intValue]);
            CGFloat topImgX = FNNewsDetailLeftBorder;
            CGFloat topImgY = pTimeY + pTimeSize.height + FNNewsDetailLeftBorder + _totalPicH;
            CGFloat topImgW = FNScreenW - 2*FNNewsDetailLeftBorder;
            CGFloat topImgH = imgH;
            CGRect imgF = CGRectMake(topImgX, topImgY, topImgW, topImgH);
            [self.pictureFs addObject:[NSValue valueWithCGRect:imgF]];
            
            NSString *altStr = _detailItem.img[i][@"alt"];
            CGSize altSize = [altStr boundingRectWithSize:CGSizeMake(FNScreenW - 2*FNNewsDetailLeftBorder, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FNNewsDetailImgAltFont]} context:nil].size;
            CGRect altF = (CGRect){FNNewsDetailLeftBorder,topImgY + topImgH + FNNewsDetailAltBorder,altSize};
            [self.altFs addObject:[NSValue valueWithCGRect:altF]];
            
            _totalPicH += (topImgH + altF.size.height + 2 * FNNewsDetailLeftBorder);
        } else {
            NSLog(@"frame");
        }
    }

    CGFloat contentY = sourceY + sourceSize.height + _totalPicH + 2*FNNewsDetailLeftBorder;
    CGRect contentRect = [detailItem.body boundingRectWithSize:CGSizeMake(FNScreenW - 2*FNNewsDetailLeftBorder, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FNNewsDetailContentBodyFont]} context:nil];
    _contentF = (CGRect){FNNewsDetailLeftBorder,contentY,contentRect.size.width,contentRect.size.height*0.95};// *0.95是暂时性调整
    
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

@end
