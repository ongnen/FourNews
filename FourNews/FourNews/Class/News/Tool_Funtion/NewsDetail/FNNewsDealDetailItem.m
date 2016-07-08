//
//  FNNewsDealDetailItem.m
//  FourNews
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsDealDetailItem.h"

@implementation FNNewsDealDetailItem

// 处理详情的文字，去掉多余字符，设置标题加粗
+ (FNNewsDetailItem *)itemWithDetailitem:(FNNewsDetailItem *)item :(void (^)(NSMutableArray *array))getStrongRange
{
    
    item.ptime = [item.ptime substringFromIndex:5];
    item.ptime = [item.ptime substringToIndex:11];
    
    NSArray *bodyArray = [item.body componentsSeparatedByString:@"</p>"];
    NSMutableArray *contArray = [NSMutableArray array];
    int ImgIndex = 0;
    for (NSString *body in bodyArray) {
        NSString *cont = [body stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
        cont = [cont stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        cont = [cont stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        
        
        if ([cont containsString:@"IMG"]) {
            NSArray *IMGArray = [cont componentsSeparatedByString:@"IMG"];
            for (int i = 0; i<IMGArray.count-1; i++) {
                UIImage *img = [[UIImage alloc] init];
                [contArray addObject:img];
                cont = [cont stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<!--IMG#%d-->",ImgIndex] withString:@""];
                ImgIndex++;
            }
        }
        
        
        [contArray addObject:cont];
    }
    item.contArray = contArray;
    
//    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 100; i++) {
//        if ([item.body containsString:@"<strong>"]) {
//            NSRange rangeFront = [item.body rangeOfString:@"<strong>"];
//            NSInteger locFront = rangeFront.location + 8;
//            NSRange rangeBack = [item.body rangeOfString:@"</strong>"];
//            NSInteger locBack = rangeBack.location;
//            [mutArray addObject:[NSValue valueWithRange:NSMakeRange(locFront-8, locBack-locFront)]];
//            getStrongRange(mutArray);
//            item.body = [item.body stringByReplacingCharactersInRange:rangeBack withString:@""];
//            item.body = [item.body stringByReplacingCharactersInRange:rangeFront withString:@""];
//        }
//    }
//    
//    for (int i = 0; i < 100; i++) {
//        if ([item.body containsString:@"<b>"]) {
//            NSRange rangeFront = [item.body rangeOfString:@"<b>"];
//            NSInteger locFront = rangeFront.location + 3;
//            NSRange rangeBack = [item.body rangeOfString:@"</b>"];
//            NSInteger locBack = rangeBack.location;
//            [mutArray addObject:[NSValue valueWithRange:NSMakeRange(locFront-3, locBack-locFront)]];
//            getStrongRange(mutArray);
//            item.body = [item.body stringByReplacingCharactersInRange:rangeBack withString:@""];
//            item.body = [item.body stringByReplacingCharactersInRange:rangeFront withString:@""];
//        }
//    }
    
    item.ec = [item.ec stringByReplacingOccurrencesOfString:item.ec withString:[NSString stringWithFormat:@"[责任编辑：%@]",item.ec]];
    
    return item;
}

@end
