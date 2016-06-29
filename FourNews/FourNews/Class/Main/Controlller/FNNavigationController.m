//
//  FNNavigationController.m
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
// _UINavigationInteractiveTransition

#import "FNNavigationController.h"
#import "FNNewsPhotoSetController.h"
#import "FNMeSettingController.h"
#import "FNMeController.h"
#import "FNSettingMostCacheController.h"
#define FNWindow [UIApplication sharedApplication].keyWindow

@interface FNNavigationController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *waveAnimaView;
@property (nonatomic, weak) UIViewController *currentVC;
@property (nonatomic, weak) FNMeSettingController *settingVC;
@property (nonatomic, weak) UIViewController *originVC;
@property (nonatomic, weak) UIImageView *screenImgV;
@property (nonatomic, assign) CGPoint firstP;
@property (nonatomic, assign) BOOL isFirstP;
@property (nonatomic, assign) BOOL isEdgeGes;
@end

@implementation FNNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isFirstP = YES;
    // 实现全屏滑动的核心方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//    [self.view addGestureRecognizer:pan];
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SettingAnimaControllerPop) name:FNSettingAnimaControllerPop object:nil];
}
// 重写push方法进行某些设置
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 1.在非根控制器下隐藏tabBar
    // 2.在非根控制器下设置全局统一样式的返回按钮
    if (self.childViewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginImage:[UIImage imageNamed:@"navigationbar_back"]] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
       
    }
    _originVC = viewController;
    UIViewController *currentVC = viewController.childViewControllers[0].childViewControllers[0];
    _currentVC = currentVC;
    if ([_currentVC isKindOfClass:[FNMeSettingController class]]) {
        _settingVC = currentVC;
    }
    if ([_currentVC isKindOfClass:[FNSettingMostCacheController class]]){
        _settingVC.isGoNext = YES;
    }
    
    [super pushViewController:viewController animated:animated];

    
}
// 返回的方法
- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGFloat panOffsetX = [pan translationInView:pan.view].x;
    panOffsetX<0 ? panOffsetX=0 : panOffsetX;
    if (_currentVC == nil) {
        _settingVC.isGoNext = NO;
        _currentVC = _settingVC;
    }
    if (![_currentVC isKindOfClass:[FNMeSettingController class]] && ![_currentVC isKindOfClass:[FNSettingMostCacheController class]]) return;
    if ([_currentVC isKindOfClass:[FNMeSettingController class]]) {
        if (pan.state == UIGestureRecognizerStateBegan) {
            _waveAnimaView = _settingVC.standHeader;
            
            [FNWindow addSubview:_waveAnimaView];
            // 正在拖拽，改变坐标
            [FNWindow bringSubviewToFront:_waveAnimaView];
            _waveAnimaView.frame = CGRectMake(panOffsetX, 64, FNScreenW, 300);
        }
        if (pan.state == UIGestureRecognizerStateChanged) {
            if (_isFirstP) {
                _isFirstP = NO;
                CGPoint panOffset = [pan translationInView:pan.view];
                if (panOffset.x&&(panOffset.x/panOffset.y>1 || panOffset.x/panOffset.y>1)) {
                    _isEdgeGes = YES;
                } else {
                    _isEdgeGes = NO;
                }
            }
            
            
            if (_isEdgeGes == NO) {
                [_waveAnimaView removeFromSuperview];
                return;
            }
            _waveAnimaView.frame = CGRectMake(panOffsetX, 64, FNScreenW, 300);
        }
    } else {
        if (pan.state == UIGestureRecognizerStateBegan) {
            if (_isFirstP) {
                CGPoint panOffset = [pan translationInView:pan.view];
                if (panOffset.y/panOffset.x>1 || panOffset.y/panOffset.x<-1) {
                    _isEdgeGes = NO;
                } else {
                    _isEdgeGes = YES;
                }
            }
            if (_isEdgeGes == NO) return;
            _waveAnimaView = _settingVC.standHeader;
            [FNWindow addSubview:_waveAnimaView];
            UIImageView *screenImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, FNScreenW, FNScreenH-49-64)];
            screenImgV.image = [self setDrawSetttingImage];
            _screenImgV = screenImgV;
            [FNWindow addSubview:_screenImgV];
            [FNWindow bringSubviewToFront:_screenImgV];
        }
        
        // 正在拖拽，改变坐标
        CGFloat panOffset = [pan translationInView:pan.view].x;
        panOffset<0 ? panOffset=0 : panOffset;
        _waveAnimaView.frame = CGRectMake(-150+panOffset*(150.0/FNScreenW), 64, FNScreenW, 300);
        
        _screenImgV.frame = CGRectMake(panOffset, 64, FNScreenW, FNScreenH-50-64);
    }
    
    // 结束拖拽时
    if (pan.state == UIGestureRecognizerStateEnded) {
        [_waveAnimaView removeFromSuperview];
        [_screenImgV removeFromSuperview];
//        _waveAnimaView = nil;
        _isFirstP = YES;
    }
        
    
    
}
// 当设置控制器出栈时移除cover
- (void)SettingAnimaControllerPop{
    [_waveAnimaView removeFromSuperview];
}
/** 拿到评论区截图 */
- (UIImage *)setDrawSetttingImage
{
//    UIView *coverV = [[UIView alloc] initWithFrame:CGRectMake(0, 64, FNScreenW, FNScreenH-49-64)];
//    [_originVC.view.superview addSubview:coverV];
//    CGRect currentFrame = _originVC.view.frame;
//    _originVC.view.frame = CGRectMake(0, -64, FNScreenW, FNScreenH);
//    [coverV addSubview:_originVC.view];
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(FNScreenW, FNScreenH-50-64), NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [_originVC.view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [image drawInRect:CGRectMake(0, -64, FNScreenW, FNScreenH-64-50)];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    // 将图片导入桌面
    NSData *data = UIImagePNGRepresentation(newImg);
    [data writeToFile:[NSString stringWithFormat:@"/Users/zyj/Desktop/imag1.png"]atomically:YES];
    return newImg;
}


@end
