//
//  UIImage+YJ.m
//  转盘
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIImage+FN.h"

@implementation UIImage (FN)

+ (NSArray *)imagesWithBigImage:(UIImage *)bigImage :(int)count
{
    NSMutableArray *mutArray = [NSMutableArray array];
    CGFloat sImageW = bigImage.size.width/count;
    CGFloat sImageH = bigImage.size.height;
    
    for (int i = 0; i < count; i++) {
        CGImageRef CGImage = CGImageCreateWithImageInRect(bigImage.CGImage, CGRectMake(2*i*sImageW, 0, 2*sImageW, 2*sImageH));
        
        UIImage *image = [UIImage imageWithCGImage:CGImage];
        [mutArray addObject:image];
        // 将图片导入桌面
//        NSData *data = UIImagePNGRepresentation(image);
//        [data writeToFile:[NSString stringWithFormat:@"/Users/admin/Desktop/imag%d.png",i]atomically:YES];
    }
    return [mutArray copy];
}

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal stretchableImageWithLeftCapWidth:w topCapHeight:h];
}

+ (UIImage *)imageWithOriginImage:(UIImage *)image
{
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageWithOriginImageName:(NSString *)image
{
    UIImage *oriImage = [UIImage imageWithOriginImage:[UIImage imageNamed:image]];
    
    return oriImage;
}

@end
