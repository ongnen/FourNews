//
//  UIImage+YJ.m
//  转盘
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIImage+FN.h"
#import <CoreImage/CoreImage.h>
#import <Accelerate/Accelerate.h>

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

+ (UIImage *)blurryImage:(UIImage *)image{
    
    
    NSInteger boxSize = (NSInteger)(10 * 5);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage; vImage_Buffer inBuffer, outBuffer, rgbOutBuffer;
    vImage_Error error; void *pixelBuffer, *convertBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    convertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    rgbOutBuffer.width = CGImageGetWidth(img);
    rgbOutBuffer.height = CGImageGetHeight(img);
    rgbOutBuffer.rowBytes = CGImageGetBytesPerRow(img);
    rgbOutBuffer.data = convertBuffer;
    inBuffer.width = CGImageGetWidth(img); inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    if (pixelBuffer == NULL) { NSLog(@"No pixelbuffer"); } outBuffer.data = pixelBuffer; outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img); outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    void *rgbConvertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) ); vImage_Buffer outRGBBuffer;
    outRGBBuffer.width = CGImageGetWidth(img);
    outRGBBuffer.height = CGImageGetHeight(img); outRGBBuffer.rowBytes = 3; outRGBBuffer.data = rgbConvertBuffer; error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend); if (error) { NSLog(@"error from convolution %ld", error);
    } const uint8_t mask[] = {2, 1, 0, 3}; vImagePermuteChannels_ARGB8888(&outBuffer, &rgbOutBuffer, mask, kvImageNoFlags);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(rgbOutBuffer.data, rgbOutBuffer.width, rgbOutBuffer.height, 5, rgbOutBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast)
    ;
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    return returnImage;
}

@end
