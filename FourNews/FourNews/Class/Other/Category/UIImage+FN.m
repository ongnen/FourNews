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

+ (UIImage *)circleImageWithBorder:(CGFloat)borderW color:(UIColor *)boderColor image:(UIImage *)oriImage {
    
    
    //1.确定边框的宽度
    //CGFloat borderW = 10;
    //2.加载图片
    //UIImage *oriImage = [UIImage imageNamed:@"阿狸头像"];
    //3.开启位图上下文(大小 原始图片的宽高度+ 2 *边框宽度)
    CGSize size = CGSizeMake(oriImage.size.width + 2 * borderW, oriImage.size.height + 2 * borderW);
    UIGraphicsBeginImageContext(size);
    //4.绘制边框(大圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [boderColor set];
    [path fill];
    //5.绘制小圆(把小圆设置成裁剪区域)
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, oriImage.size.width, oriImage.size.height)];
    [clipPath addClip];
    //6.把图片绘制到上下文当中
    [oriImage drawAtPoint:CGPointMake(borderW, borderW)];
    //7.从上下文当中生成图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //8.关闭上下文.
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)colorImageWithColor:(UIColor *)color
{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), YES, 0);
    // 绘制一个像素点的矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, 1)];
    // 加颜色
    [color set];
    // 路径添加
    [path fill];
    // 拿到图片
    UIImage  *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
