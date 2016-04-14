//
//  YJGridView.m
//  支付宝
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJGridView.h"

@interface YJGridView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, assign) CGPoint startP;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger fromIndex;
@property (nonatomic, assign) NSInteger toIndex;

@end

@implementation YJGridView

+ (instancetype)gridViewWithlist:(NSArray *)items
{
    YJGridView *gridView = [[YJGridView alloc] init];

    gridView.itemArray = items;
    
    for (int i = 0; i < 11; i++) {
        UIView *view = [[UIView alloc ] init];
        if (i < 4) {
            view = [[UIView alloc] initWithFrame:CGRectMake(FNScreenW/4 * (i+1), 0, 0.5, FNScreenW/4 * 6)];
        } else {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, FNScreenW/4 * (i-4), FNScreenW, 0.5)];
        }
        view.backgroundColor = FNColor(200, 200, 200);
        [gridView addSubview:view];
    }
    
    return gridView;
}

- (void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    for (int i = 0; i < itemArray.count; i++) {
        YJGridItemListView *itemView = [[YJGridItemListView alloc] init];
        itemView.index = i;
        itemView.btnClickBlock = ^(YJGridItemListButton *btn){
            [self listBtnClick:btn];
        };
        itemView.btnLongPress = ^(UILongPressGestureRecognizer *longP){
            [self btnLongPress:longP];
        };
        YJGridButtonitem *item = itemArray[i];
        itemView.item = item;
        itemView.frame = [self frameWithIndex:i];
        [self addSubview:itemView];
    }
}

- (void)listBtnClick:(YJGridItemListButton *)btn
{
    if (self.listBtnClickBlock) {
        self.listBtnClickBlock((YJGridItemListView *)btn.superview);
    }
}

- (void)btnLongPress:(UILongPressGestureRecognizer *)longP {
    
    YJGridItemListView *pressedView = (YJGridItemListView *)longP.view.superview;
    CGPoint curP = [longP locationInView:self];
    if (longP.state == UIGestureRecognizerStateBegan) {
        self.startP = [longP locationInView:self];
        [self bringSubviewToFront:pressedView];
        pressedView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        
        NSInteger indexX = curP.x / ((NSInteger)FNScreenW/4);
        NSInteger indexY = (NSInteger)(curP.y / ((NSInteger)FNScreenW/4)) * 4;
        NSInteger fromIndex = indexX + indexY;
        self.fromIndex = fromIndex;
    }
    CGPoint disP = CGPointMake(curP.x - self.startP.x, curP.y - self.startP.y);
    pressedView.transform = CGAffineTransformMakeTranslation(disP.x, disP.y);
    
    NSInteger indexX = curP.x / ((NSInteger)FNScreenW/4);
    NSInteger indexY = (NSInteger)(curP.y / ((NSInteger)FNScreenW/4)) * 4;
    NSInteger toIndex = indexX + indexY;
    if (self.toIndex != toIndex && toIndex < 20) {
        self.toIndex = toIndex;
        [self reSetListViewFrame:self.fromIndex :self.toIndex];
    }
    
    if (longP.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.2 animations:^{
            [UIView animateWithDuration:0.2 animations:^{
                pressedView.transform = CGAffineTransformMakeTranslation(0, 0);
                pressedView.frame = [self frameWithIndex:self.toIndex];
                [self sendSubviewToBack:pressedView];
            }];
        }];
    }
}
// 交换位置的核心方法
- (void)reSetListViewFrame:(NSInteger)fromIndex :(NSInteger)toIndex
{
    NSLog(@"%ld----%ld",fromIndex,toIndex);
    for (YJGridItemListView *view in self.subviews) {
        if ([view isKindOfClass:[YJGridItemListView class]] && view.index >= fromIndex && view.index <= toIndex) {
            if (view.index == fromIndex) {
                view.index = toIndex;
                self.fromIndex = toIndex;
                NSLog(@"cur %ld",view.index);
            } else {
                NSLog(@"%ld",view.index);
                view.index--;
                [UIView animateWithDuration:0.2 animations:^{
                    view.frame = [self frameWithIndex:view.index];
                }];
             }
        } else if ([view isKindOfClass:[YJGridItemListView class]] && view.index >= toIndex && view.index <= fromIndex) {
            if (view.index == fromIndex) {
                view.index = toIndex;
                self.fromIndex = toIndex;
                NSLog(@"cur %ld",view.index);
            } else {
                NSLog(@"%ld",view.index);
                view.index++;
                [UIView animateWithDuration:0.2 animations:^{
                    view.frame = [self frameWithIndex:view.index];
                }];
            }
        }
    }
}
// 根据标记计算位置
- (CGRect)frameWithIndex:(NSInteger)index
{
    CGFloat X = index % 4 * FNScreenW/4;
    CGFloat Y = index / 4 * FNScreenW/4;
    CGFloat W = FNScreenW/4;
    CGFloat H = FNScreenW/4;
    return CGRectMake(X, Y, W, H);
}
@end


#define YJBusiWidth [UIScreen mainScreen].bounds.size.width / 4


@implementation YJGridItemListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setItem:(YJGridButtonitem *)item
{
    YJGridItemListButton *btn = [[YJGridItemListButton alloc] init];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.image]]];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:item.desc forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDragInside];
    
    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongPress:)];
    [btn addGestureRecognizer:longP];
    
    [self addSubview:btn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.subviews[0].frame = self.bounds;
}

- (void)btnClick:(YJGridItemListButton *)btn
{
    if (self.btnClickBlock) {
        self.btnClickBlock(btn);
    }
}

- (void)btnLongPress:(UILongPressGestureRecognizer *)longP {
    if (self.btnLongPress) {
        self.btnLongPress(longP);
    }
}
@end


@implementation YJGridItemListButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(YJBusiWidth * 1 / 3, YJBusiWidth * 1 / 3, YJBusiWidth * 1 / 3, YJBusiWidth * 1 / 3);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, YJBusiWidth * 2 / 3, YJBusiWidth, YJBusiWidth * 1 / 3);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end

@implementation YJGridButtonitem

+ (YJGridButtonitem *)Cellitem:(NSString *)desc :(NSString *)image :(NSInteger)index
{
    YJGridButtonitem *item = [[YJGridButtonitem alloc] init];
    item.desc = desc;
    item.image = [UIImage imageNamed:image];
    item.index = index;
    
    return item;
}

+ (NSArray *)gridItems
{
    NSMutableArray *itemArray = [NSMutableArray array];
    
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝0" :@"i00" :0]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝1" :@"i01" :1]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝2" :@"i02" :2]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝3" :@"i03" :3]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝4" :@"i04" :4]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝5" :@"i05" :5]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝6" :@"i06" :6]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝7" :@"i07" :7]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝8" :@"i08" :8]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝9" :@"i09" :9]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝10" :@"i10" :10]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝11" :@"i11" :11]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝12" :@"i12" :12]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝13" :@"i13" :13]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝14" :@"i14" :14]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝15" :@"i15" :15]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝16" :@"i16" :16]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝17" :@"i17" :17]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝18" :@"i18" :18]];
    [itemArray addObject:[YJGridButtonitem Cellitem:@"淘宝19" :@"i19" :19]];
    
    
    return itemArray;
}

@end