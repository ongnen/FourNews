//
//  NewFeatureController.m
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "NewFeatureController.h"
#import "NewFeatureCell.h"

@interface NewFeatureController ()

@end

@implementation NewFeatureController

static NSString *const reslult =@"cell";

//流水布局
-(instancetype)init
{
    UICollectionViewFlowLayout *flowLa = [[UICollectionViewFlowLayout alloc]init];
    //设置每个格子的大小
    flowLa.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    flowLa.minimumInteritemSpacing = 0;
    
    flowLa.minimumLineSpacing = 0;
    
    flowLa.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    return [super initWithCollectionViewLayout:flowLa];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerClass:[NewFeatureCell class] forCellWithReuseIdentifier:reslult];
    //取消弹簧
    self.collectionView.bounces = NO;
    //分页
    self.collectionView.pagingEnabled =YES;

    
}

//设置我们的数据局
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//设置我们多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return 4;
}
//设置我们的cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reslult forIndexPath:indexPath];
    
     cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.item + 1]];
    
    [cell setStartBtnIndex:indexPath count:4];
    return cell;

}

@end
