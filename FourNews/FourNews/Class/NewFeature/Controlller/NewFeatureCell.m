//
//  NewFeatureCell.m
//  FourNews
//
//  Created by xuxisong on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "NewFeatureCell.h"
#import "FNTabBarController.h"
@interface NewFeatureCell ()

@property (nonatomic,weak)UIImageView *imageV;

@property (nonatomic, weak) UIButton *startBtn;

@end
@implementation NewFeatureCell
//懒加载btn

-(UIButton *)startBtn
{
    if (_startBtn == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        [startBtn sizeToFit];
        startBtn.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.8);
        _startBtn = startBtn;
        [self.contentView addSubview:startBtn];
        [startBtn addTarget:self action:@selector(setUn) forControlEvents:UIControlEventTouchUpInside ];
        
        
    }


    return _startBtn;


}

-(void)setUn

{//跳转
    FNTabBarController *tabbar = [[FNTabBarController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController =tabbar;
    
}



//懒加载
-(UIImageView *)imageV
{
    if (_imageV == nil) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.frame = self.bounds;
        
        [self.contentView addSubview:imageV];
        _imageV = imageV;
    }
    return _imageV;

}



-(void)setImage:(UIImage *)image
{
    _image =image;
    self.imageV.image =image;

}

-(void)setStartBtnIndex:(NSIndexPath *)index count:(int)count
{
    if (index.item == count-1) {
        self.startBtn.hidden = NO;
    }else
    {
    
        self.startBtn.hidden = YES;
    }


}

@end
