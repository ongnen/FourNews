//
// 1.将大图片裁剪成一定数量的的小图片，数组形式返回

// 2.返回一张可以随意拉伸不变形的图片
#import <UIKit/UIKit.h>

@interface UIImage (FN)

//将大图片裁剪成一定数量的的小图片，数组形式返回
+ (NSArray *)imagesWithBigImage:(UIImage *)bigImage :(int)count;

//返回一张可以随意拉伸不变形的图片
+ (UIImage *)resizableImage:(NSString *)name;

//返回一张不经过渲染，原始的图片
+ (UIImage *)imageWithOriginImage:(UIImage *)image;
+ (UIImage *)imageWithOriginImageName:(NSString *)image;

/**
 *  返回一个带有边框的圆形裁剪图片
 *
 *  @param borderW    边框宽度
 *  @param boderColor 边框颜色
 *  @param oriImage   要裁剪的图片
 *
 *  @return 已经裁剪好的带有边框的图片
 */
+ (UIImage *)circleImageWithBorder:(CGFloat)borderW color:(UIColor *)boderColor image:(UIImage *)oriImage;

// 由颜色产生一张图片

+ (UIImage *)colorImageWithColor:(UIColor *)color;

// 产生一张带毛玻璃效果的图片
+ (UIImage *)blurryImage:(UIImage *)image;

@end