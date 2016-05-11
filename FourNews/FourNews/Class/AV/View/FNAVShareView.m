//
//  FNAVShareView.m
//  FourNews
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVShareView.h"
#import <OpenShareHeader.h>
#import "MBProgressHUD+MJ.h"

@interface FNAVShareView ()



@end

@implementation FNAVShareView

+ (instancetype)avShareView
{
    return  [[NSBundle mainBundle] loadNibNamed:@"FNAVShareView" owner:nil options:nil].lastObject;
}


- (IBAction)shareToQQZone:(id)sender {
    OSMessage *message = [[OSMessage alloc] init];
    
    message.title = [NSString stringWithFormat:@"%@ %@",_item.descrip,_item.mp4_url];
    [OpenShare shareToQQZone:message Success:^(OSMessage *message) {
        [MBProgressHUD showSuccess:@"分享成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [MBProgressHUD showError:@"分享失败"];
    }];
}
- (IBAction)shareToSina:(id)sender {
    OSMessage *message = [[OSMessage alloc] init];
    
    message.title = [NSString stringWithFormat:@"%@ %@",_item.descrip,_item.mp4_url];
    
    [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
        [MBProgressHUD showSuccess:@"分享成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [MBProgressHUD showError:@"分享失败"];
    }];
}

- (IBAction)shareToWechat:(id)sender {
    OSMessage *message = [[OSMessage alloc] init];
    
    message.title = [NSString stringWithFormat:@"%@ %@",_item.descrip,_item.mp4_url];
    [OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
        [MBProgressHUD showSuccess:@"分享成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [MBProgressHUD showError:@"分享失败"];
    }];
}
- (IBAction)closeBtnClick:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
}

@end
