//
//  FNLabel.m
//  FNLabelDemo
//
//  Created by ZYJ on 12-11-8.
//   2012年 ZYJ
// NSAttributedString用法

#import "FNLabel.h"
#import <CoreText/CoreText.h>

@implementation FNLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self formatString];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 从文本空间到用户控件的转换矩阵
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    // 缩放范围
    CGContextTranslateCTM(ctx,0, self.bounds.size.height);
    // 调整正确的坐标系
    CGContextScaleCTM(ctx, 1.0, -1.0);
    
    // 1.由富文本得到framesetter
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_string);
    // 2.由self.bounds得到path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    // 3.由framesetter(内涵文本内容)，range(要画的范围)，path文本矩形 得到CTFrameRef
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [_string length]), path, NULL);
    // 4.画文本
    CTFrameDraw(frame, ctx);
    
    CFRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
}
#pragma mark - 普通的两端对齐文本
- (void)setText:(NSString *)text
{
    _string = [[NSMutableAttributedString alloc] initWithString:text];
    if (_textColor) {
        [_string addAttribute:NSForegroundColorAttributeName value:_textColor range:NSMakeRange(0, [_string length])];
    }
    if (_font) {
        [_string addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, [_string length])];
    }
    [self setNeedsDisplay];
}
//#pragma mark - 保存整体文字颜色
//- (void)setTextColor:(UIColor *)textColor
//{
//    _textColor = textColor;
//}
//#pragma mark - 保存整体字体
//- (void)setFont:(UIFont *)font
//{
//    _font = font;
//}
#pragma mark - 添加所有富文本属性
- (void)setString:(NSMutableAttributedString *)string
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string.string];
    
    _string = str;
    // 设置文字颜色
    if (_textColor == nil) {
        _textColor = [UIColor blackColor];
    }
    [_string addAttribute:NSForegroundColorAttributeName value:_textColor range:NSMakeRange(0, [string length])];
    if (_font == nil) {
        _font = [UIFont systemFontOfSize:20];
    }
    // 设置文字字体
    [_string addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, [string length])];
    
    // 遍历添加所有字体文本属性
    [string enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, _string.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value) {
            [_string addAttribute:NSFontAttributeName value:value range:range];
            [self setNeedsDisplay];
        }
    }];
    // 遍历添加所有颜色文本属性
    [string enumerateAttribute:NSForegroundColorAttributeName inRange:NSMakeRange(0, _string.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value) {
            [_string addAttribute:NSForegroundColorAttributeName value:value range:range];
            [self setNeedsDisplay];
        }
    }];
}
#pragma mark - 添加两端对齐属性
- (void)formatString
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentJustified;
    style.lineSpacing = 5;
    [_string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, _string.length)];
}


@end
