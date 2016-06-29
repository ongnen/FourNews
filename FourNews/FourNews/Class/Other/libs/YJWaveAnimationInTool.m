//
//  YJWaveAnimationInCircle.m
//  WaveAnimate
//
//  Created by admin on 16/5/7.
//  Copyright © 2016年 xmg. All rights reserved.
//


#import "YJWaveAnimationInTool.h"


@interface YJWaveAnimationTool()

@property (nonatomic, strong) CALayer *waveLayer;

@property (nonatomic, weak) UIImageView *circleRotaV;
@property (nonatomic, weak) UIImageView *circleWaveImgV;
@property (nonatomic, weak) UIImageView *waveImgView;

@property (nonatomic, strong) CAKeyframeAnimation *animPosition;

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, assign) CGFloat circleWaveImgH;



@property (nonatomic, assign) CGFloat realPersent;
@property (nonatomic, assign) CGFloat bottomPersent;

@end

@implementation YJWaveAnimationTool


//1.静态变量
static YJWaveAnimationTool *_instance;

//2.重写分配空间的方法
//+(instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [super allocWithZone:zone];
//        
//    });
//    return _instance;
//}

//3.提供类方法
+(instancetype)shareWaveAnimationTool
{
    return [[self alloc]init];
}


- (void)raiseAnimationWithDuration:(NSTimeInterval)interval toPersent:(CGFloat)persent target:(id)target action:(SEL)action completion:(void (^)())completeBlock{

    // 执行传递进来的方法
    if (target && action) {
        [target performSelector:action];
    }
    
    CABasicAnimation * transformRoate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    transformRoate.byValue = [NSNumber numberWithDouble:(2 * M_PI)];
    transformRoate.duration = 2;
    transformRoate.repeatCount = MAXFLOAT;
    transformRoate.removedOnCompletion = NO;
    [self.circleRotaV.layer addAnimation:transformRoate forKey:@"transformRoate"];
    
    
    UIImageView *waveImgView = [[UIImageView alloc] init];
    waveImgView.frame = CGRectMake(0, 0, self.circleWaveImgH*2*2, self.circleWaveImgH*2);
    [self.circleWaveImgV addSubview:waveImgView];
    UIImage *waveImg = [UIImage imageNamed:@"fb_wave"];
    waveImgView.image = waveImg;
    self.waveImgView = waveImgView;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    self.path = path;
    CGFloat startPersent = self.bottomPersent;
    [path moveToPoint:CGPointMake(0, self.circleWaveImgH+(1-startPersent)*self.circleWaveImgH)];
    [path addLineToPoint:CGPointMake(self.circleWaveImgH*2, self.circleWaveImgH+(1-startPersent)*self.circleWaveImgH)];
    
    // 帧动画
    CAKeyframeAnimation *animPosition = [CAKeyframeAnimation animation];
    animPosition.keyPath = @"position";
    animPosition.duration = 2;
    animPosition.path = path.CGPath;
    animPosition.repeatCount = MAXFLOAT;
    self.animPosition = animPosition;
    animPosition.removedOnCompletion = NO;
    animPosition.fillMode = kCAFillModeForwards;
    
    // 基动画
    CGFloat toPersent = persent;
    CABasicAnimation *animTranslate = [CABasicAnimation animation];
    animTranslate.keyPath = @"position.y";
    animTranslate.byValue = @((startPersent-toPersent)*self.circleWaveImgH);
    animTranslate.duration = 1;
    animTranslate.removedOnCompletion = NO;
    animTranslate.fillMode = kCAFillModeForwards;
    
    
    [waveImgView.layer addAnimation:animPosition forKey:@"animPosition"];
    [waveImgView.layer addAnimation:animTranslate forKey:@"animTranslate"];
    self.realPersent = persent;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completeBlock) {
            completeBlock();
        }
    });
    
}


- (void)fallAnimationWithDuration:(NSTimeInterval)interval target:(id)target action:(SEL)action completion:(void (^)())completeBlock
{
    // 执行传递进来的方法
    if (target && action) {
        [target performSelector:action];
    }
    
    
    // 移除上一组动画
    [self.waveImgView.layer removeAnimationForKey:@"animPosition"];
    [self.waveImgView.layer removeAnimationForKey:@"animTranslate"];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.circleWaveImgH+(1-self.realPersent)*self.circleWaveImgH)];
    [path addLineToPoint:CGPointMake(self.circleWaveImgH*2, self.circleWaveImgH+(1-self.realPersent)*self.circleWaveImgH)];
    self.animPosition.path = path.CGPath;
    self.animPosition.duration = 0.5;
    [self.waveImgView.layer addAnimation:self.animPosition forKey:@"animPosition"];
    
    // 基动画
    
    CABasicAnimation *animTranslate = [CABasicAnimation animation];
    animTranslate.keyPath = @"position.y";
    animTranslate.byValue = @((self.realPersent-_bottomPersent)*self.circleWaveImgH);
    animTranslate.duration = 1.0;
    animTranslate.removedOnCompletion = NO;
    animTranslate.fillMode = kCAFillModeForwards;
    [animTranslate setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.waveImgView.layer addAnimation:animTranslate forKey:@"animTranslate"];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.realPersent = _bottomPersent;
        // 执行完成回调
        if (completeBlock) {
            completeBlock();
        }
        [self.waveImgView.layer removeAnimationForKey:@"animPosition"];
        [self.waveImgView.layer removeAnimationForKey:@"animTranslate"];
        
        CGFloat persent = 0.1;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, self.circleWaveImgH+(1-persent)*self.circleWaveImgH)];
        [path addLineToPoint:CGPointMake(self.circleWaveImgH*2, self.circleWaveImgH+(1-persent)*self.circleWaveImgH)];
        self.animPosition.path = path.CGPath;
        self.animPosition.duration = 2.0;
        [self.waveImgView.layer addAnimation:self.animPosition forKey:@"animPosition"];
    });
}

- (void)setInView:(UIView *)inView
{
    _inView = inView;
    _bottomPersent = 0.1;
    
    for (UIView *view in inView.subviews) {
        if (view.tag == 9999) {
            return;
        }
    }
    
    CGFloat circleRotaH = 150;
    CGFloat circleWaveImgH = circleRotaH*14/15;
    self.circleWaveImgH = circleWaveImgH;
    
    if (self.waveView.frame.size.width == 0) {
        self.waveView.bounds = CGRectMake(0, 0, circleWaveImgH, circleWaveImgH);
        self.waveView.center = CGPointMake(self.inView.frame.size.width/2, self.inView.frame.size.height/2);
    }
    
    UIImageView *circleRotaV = [[UIImageView alloc] init];
    circleRotaV.image = [UIImage imageNamed:@"circleImgV"];
    circleRotaV.bounds = CGRectMake(0, 0, circleRotaH, circleRotaH);
    circleRotaV.center = CGPointMake(self.waveView.frame.size.width/2, self.waveView.frame.size.height/2);
    [self.waveView addSubview:circleRotaV];
    [self.inView addSubview:self.waveView];
    
    UIImageView *circleWaveImgV = [[UIImageView alloc] init];
    circleWaveImgV.frame = CGRectMake(0, 0, circleWaveImgH, circleWaveImgH);
    circleWaveImgV.layer.cornerRadius = circleWaveImgH/2;
    circleWaveImgV.clipsToBounds = YES;
    [self.waveView addSubview:circleWaveImgV];
    
    self.persentL.frame = self.inView.bounds;
    [self.inView addSubview:self.persentL];
    
    
    self.circleWaveImgV = circleWaveImgV;
    
    self.circleRotaV = circleRotaV;
    self.circleWaveImgV.alpha = 0.8;
}

- (UILabel *)persentL
{
    if (!_persentL){
        self.persentL = [[UILabel alloc] init];
    }
    return _persentL;
}

- (UIView *)waveView
{
    if (!_waveView){
        UIView *waveView = [[UIView alloc] init];
        [self.inView addSubview:waveView];
//        waveView.tag = 9999;
        _waveView = waveView;
    }
    return _waveView;
}

- (void)removeAnimation
{
    self.waveView = nil;
    [self.waveView removeFromSuperview];
}

#pragma mark - 动画2
- (void)addWaveAnimationWithWaveHeight:(CGFloat)height view:(UIView *)view alpha:(CGFloat)alpha
{
    
    UIView *boxView = [[UIView alloc] init];
    boxView.frame = view.bounds;
    boxView.alpha = alpha;
    [view addSubview:boxView];
    view.clipsToBounds = YES;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat waveW = view.frame.size.width;
    CGFloat waveH = view.frame.size.height;
    [path moveToPoint:CGPointMake(0, waveH/2+(waveH-height))];
    
    
    [path addLineToPoint:CGPointMake(waveW, waveH/2+(waveH-height))];
    
    CALayer *waveLayer = [CALayer layer];
    self.waveLayer = waveLayer;
    [boxView.layer addSublayer:waveLayer];
    UIImage *waveImg = [UIImage imageNamed:@"fb_wave"];
    
    waveLayer.frame = CGRectMake(0, 0, 4*waveW, waveH);
    waveLayer.contents = (__bridge id _Nullable)(waveImg.CGImage);
    
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    
    anim.duration = 2;
    anim.path = path.CGPath;
    anim.repeatCount = MAXFLOAT;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.autoreverses = NO;
    [self.waveLayer addAnimation:anim forKey:nil];
}

@end


@implementation UIView (waveAnimation)
- (void)addWaveAnimationWithWaveHeight:(CGFloat)height alpha:(CGFloat)alpha
{
    [[YJWaveAnimationTool shareWaveAnimationTool] addWaveAnimationWithWaveHeight:height view:self  alpha:alpha];
}

@end
