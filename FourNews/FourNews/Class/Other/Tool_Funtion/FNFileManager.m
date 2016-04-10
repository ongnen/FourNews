//
//  FNFileManager.m
//  FNBudejie
//
//  Created by admin on 16/4/6.
//  Copyright © 2016年 天涯海北. All rights reserved.∫
//

#import "FNFileManager.h"
#import <SDImageCache.h>

@implementation FNFileManager

+ (NSInteger)getSizeWithFilePath:(NSString *)path
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断传入路径是否正确，否则直接报错
    NSException *excp = [NSException exceptionWithName:@"path error" reason:@"please give a right Directory" userInfo:nil];
    BOOL isDirectory;
    BOOL exist = [mgr fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isDirectory || !exist) {
        [excp raise];
    }
    
    NSInteger fileSize = 0;
    
    
    // 获得所有子路径，包括子路径的子路径
    NSArray *fileArray = [mgr subpathsAtPath:path];
    
    for (NSString *file in fileArray) {
        NSString *totalPath = [path stringByAppendingPathComponent:file];
        // 这个方法返回文件是否存在 指针&isDirectory返回是否是文件
        [mgr fileExistsAtPath:totalPath isDirectory:&isDirectory];
        
        if ([file containsString:@"DS_"] || isDirectory) {
            continue;
        }
        // 拿到文件路径对应的属性
        NSDictionary *attr = [mgr attributesOfItemAtPath:totalPath error:nil];
        fileSize += attr.fileSize;
    }
    return fileSize;
}


+ (void)clearDiskWithFilePath:(NSString *)path
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获得该路径下的子一级目录
    NSArray *fileArray = [mgr contentsOfDirectoryAtPath:path error:nil];
    for (NSString *file in fileArray) {
        NSString *totalPath = [path stringByAppendingPathComponent:file];
        // 删除路径下的所有文件包括当前文件夹
        [mgr removeItemAtPath:totalPath error:nil];
    }
}

@end
