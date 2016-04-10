//
//  FNFileManager.h
//  FNBudejie
//
//  Created by admin on 16/4/6.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNFileManager : NSObject

+ (NSInteger)getSizeWithFilePath:(NSString *)path;

+ (void)clearDiskWithFilePath:(NSString *)path;

@end
