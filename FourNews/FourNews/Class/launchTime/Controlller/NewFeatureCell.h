//
//  NewFeatureCell.h
//  FourNews
//
//  Created by xuxisong on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureCell : UICollectionViewCell

//设置图片
@property (nonatomic,strong) UIImage *image;


//设置我们的按钮
-(void)setStartBtnIndex:(NSIndexPath *)index count:(int)count;
@end
