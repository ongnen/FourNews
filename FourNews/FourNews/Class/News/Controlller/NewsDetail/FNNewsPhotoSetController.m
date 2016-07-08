//
//  FNNewsPhotoSetController.m
//  FourNews
//
//  Created by admin on 16/4/5.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsPhotoSetController.h"
#import "FNNewsGetPhotoSetItem.h"
#import "FNNewsPhotoDescView.h"
#import <UIImageView+WebCache.h>
#import "FNNewsReplyButton.h"
#import "FNNewsReplyController.h"
#define FNNewsPhotoBorder50 50


@interface FNNewsPhotoSetController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *imageCollecV;
@property(nonatomic, weak) FNNewsPhotoDescView *descView;

@end

@implementation FNNewsPhotoSetController
static NSString * const ID = @"collec";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setImageCollecV];
    [FNNewsGetPhotoSetItem getNewsDetailWithPhotoid:_photoSetid :^(NSArray* array) {
        self.photoSet = array;
        self.imageCollecV.frame = CGRectMake(0, 0, FNScreenW, FNScreenH);
        [self.imageCollecV reloadData];
        [self saveHistorySkim];
        [self setBottomDescView];
    }];
    
    [self setBottomImgV];
    [self setTopBtns];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark - 记录浏览历史
- (void)saveHistorySkim
{
    NSMutableArray *historySkim = [[FNUserDefaults objectWithKey:@"historySkim"] mutableCopy];
    id item = [NSKeyedUnarchiver unarchiveObjectWithData:historySkim.lastObject];
    // 与上次是访问相同新闻则不添加到历史
    if (![[item title] isEqualToString:_listItem.title]) {
        NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:_listItem];
        [historySkim addObject:listData];
    }
    
    [FNUserDefaults setObject:historySkim forKey:@"historySkim"];
}
- (void)setPhotoSet:(NSArray *)photoSet
{
    _photoSet = photoSet;
    
}

- (void)setImageCollecV
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 布局模式
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // cell尺寸
    layout.itemSize = self.view.bounds.size;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    // 滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collecV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    UIImageView *collecBackGroundV = [[UIImageView alloc] init];
    collecBackGroundV.image = [UIImage imageNamed:@"photosetBackGround"];
    collecBackGroundV.frame = collecV.bounds;
    collecV.backgroundView = collecBackGroundV;
    collecV.pagingEnabled = YES;
    // 数据源
    collecV.dataSource = self;
    collecV.delegate = self;
    // 注册cell
    [collecV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    // 加入父控件
    [self.view addSubview:collecV];
    self.imageCollecV = collecV;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoSet.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.imageCollecV dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    // 消除循环利用数据错误
    [cell.subviews.lastObject removeFromSuperview];
    UIImageView *imageV = [[UIImageView alloc] init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.photoSet[indexPath.row].imgurl] placeholderImage:[UIImage imageNamed:@"newsTitleImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [imageV sizeToFit];
        imageV.bounds = CGRectMake(0, 0, FNScreenW, imageV.height * FNScreenW/imageV.width);
        imageV.center = CGPointMake(FNScreenW/2, FNScreenH/2);
    }];
    [cell addSubview:imageV];
    
    return cell;
}

- (void)setBottomImgV
{
    UIImageView *botomImgV = [[UIImageView alloc] init];
    botomImgV.image = [UIImage imageNamed:@"photoSetBottom"];
    botomImgV.frame = CGRectMake(0, self.view.height-FNBottomBarHeight, FNScreenW, FNBottomBarHeight);
    [self.view addSubview:botomImgV];
}

- (void)setBottomDescView
{
    FNNewsPhotoDescView *descView = [[NSBundle mainBundle] loadNibNamed:@"FNNewsPhotoDescView" owner:nil options:nil].lastObject;
    descView.descItem = _photoSet[0];
    CGFloat descViewH = [FNNewsPhotoDescView heightWithPhotoSet:_photoSet];
    descView.frame = CGRectMake(0, self.view.height-FNBottomBarHeight-descViewH, FNScreenW, descViewH);
    descView.indexL.text = [NSString stringWithFormat:@"1/%ld",(unsigned long)_photoSet.count];
    self.descView = descView;
    [self.view addSubview:descView];
}

#pragma mark - UIScrollViewDelegate
// 当一个item现实完毕时调用

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/FNScreenW;
    self.descView.descItem = _photoSet[index];
    self.descView.indexL.text = [NSString stringWithFormat:@"%ld/%ld",index+1,_photoSet.count];
}

- (void)setTopBtns
{
    // 左边返回按钮
    UIButton *backBtn = [[UIButton alloc] init];
    backBtn.frame = CGRectMake(10, 20, 40, 40);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"weather_back"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    // 右边评论按钮
    FNNewsReplyButton *replyBtn = [[FNNewsReplyButton alloc] init];
    NSString *replyStr = [NSString stringWithFormat:@"%ld评论",(long)_listItem.replyCount];
    CGSize replyBtnSize = [replyStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [replyBtn addTarget:self action:@selector(replyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    replyBtn.frame = (CGRect){FNScreenW-replyBtnSize.width-10, 25,replyBtnSize.width+10,30};
    [replyBtn setTitle:replyStr forState:UIControlStateNormal];
    [replyBtn setImage:[UIImage resizableImage:@"contentview_commentbacky"] forState:UIControlStateNormal];
    replyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:replyBtn];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)replyBtnClick
{
    FNNewsReplyController *replyVC = [[FNNewsReplyController alloc] init];
    replyVC.docid = _listItem.postid;
    replyVC.boardid = _listItem.boardid;
    [self.navigationController pushViewController:replyVC animated:YES];
    
}


@end
