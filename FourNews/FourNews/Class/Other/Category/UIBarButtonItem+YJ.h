/**
 *  快速创建一个显示图片的item
 */

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YJ)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
