//
//  FNNewsQRCodeScanController.h
//  FourNews
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNNewsQRCodeScanController : UIViewController

@property (nonatomic, strong) void(^receiveQRCodeInformate)(NSString *);

@end
