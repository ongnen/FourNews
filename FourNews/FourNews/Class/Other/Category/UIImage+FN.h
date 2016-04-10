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
@end
