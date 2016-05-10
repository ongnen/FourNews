//
//  YJWaveAnimationInCircle.h
//  WaveAnimate
//
//  Created by admin on 16/5/7.
//  Copyright © 2016年 xmg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (waveAnimation)
- (void)addWaveAnimationWithWaveHeight:(CGFloat)height alpha:(CGFloat)alpha;
@end


@interface YJWaveAnimationTool : NSObject

@property (nonatomic, weak) UIView *waveView;

@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic, strong) UILabel *persentL;

@property (nonatomic, weak) UIView *inView;


+(instancetype)shareWaveAnimationTool;

// 水位上升的动画，传入想做的事和动画完成后的回调
- (void)raiseAnimationWithDuration:(NSTimeInterval)interval toPersent:(CGFloat)persent target:(nullable id)target action:(nullable SEL)action completion:(void(^_Nullable)())completeBlock;

// 水位下降的动画，传入想做的事和动画完成后的回调
- (void)fallAnimationWithDuration:(NSTimeInterval)interval target:(nullable id)target action:(nullable SEL)action completion:(void(^_Nullable)())completeBlock;

- (void)removeAnimation;

@end
