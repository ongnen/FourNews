//
//  YJInfiniteScrollView.m
//  轮播器控件封装
//
//  Created by admin on 16/4/21.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "YJInfiniteScrollView.h"

#define totleCount (_images.count*3)

@interface YJInfiniteScrollView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionV;

@property (nonatomic, weak) NSTimer *timer;

@end

@implementation YJInfiniteScrollView

static NSString * const ID = @"cell";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(void)setImages:(NSArray *)images
{
    _images = images;
    
    UICollectionViewFlowLayout *layout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumLineSpacing = 0;
        
        layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout;
    });
    
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    
    collectionV.backgroundColor = [UIColor orangeColor];
    
    collectionV.pagingEnabled = YES;
    collectionV.scrollEnabled = YES;
    collectionV.dataSource = self;
    collectionV.delegate = self;
    collectionV.showsHorizontalScrollIndicator = NO;
    collectionV.showsVerticalScrollIndicator = NO;
    collectionV.scrollsToTop = NO;
    collectionV.contentSize = CGSizeMake(totleCount*self.frame.size.width, self.frame.size.height);
    
    [collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    [collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:totleCount/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    [self addSubview:collectionV];
    self.collectionV = collectionV;
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(goNextPage) userInfo:nil repeats:YES];
    // 将定时器source添加两种模式
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return totleCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell.contentView.subviews.count) {
        [cell.contentView.subviews[0] removeFromSuperview];
    }
    
    UIImageView *ADImageV = [[UIImageView alloc] init];
    ADImageV.userInteractionEnabled = YES;
    ADImageV.frame = cell.bounds;
    ADImageV.image = _images[indexPath.item%_images.count];
    
    [cell.contentView addSubview:ADImageV];
    
    return cell;
}

// 始终在中间位置附近滚动的逻辑代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x>self.frame.size.width*_images.count*2) {
        self.collectionV.contentOffset = CGPointMake(self.collectionV.contentOffset.x-self.frame.size.width*_images.count, 0);
    } else if (scrollView.contentOffset.x<self.frame.size.width*_images.count) {
        self.collectionV.contentOffset = CGPointMake(self.collectionV.contentOffset.x+self.frame.size.width*_images.count, 0);
    }
}
// 开始拖拽时移除定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}
// 结束拖拽时加上定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(goNextPage) userInfo:nil repeats:YES];
    // 将定时器source添加两种模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer = timer;
}

- (void)goNextPage
{
    [self.collectionV setContentOffset:CGPointMake(self.collectionV.contentOffset.x+self.frame.size.width, 0) animated:YES];
}


@end
