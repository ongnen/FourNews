//
//  FNNewsHistoryView.m
//  FourNews
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsHistoryView.h"
#import "FNNewsHotWordButton.h"


@interface FNNewsHistoryView ()
@property (weak, nonatomic)  FNNewsHotWordButton *historySkim1;
@property (weak, nonatomic)  FNNewsHotWordButton *historySkim2;


@end

@implementation FNNewsHistoryView

- (void)awakeFromNib
{
    [self setupSkimBtnWithIndex:1];
    [self setupSkimBtnWithIndex:2];
}


- (void)setupSkimBtnWithIndex:(NSInteger)index
{
    NSArray *historyS = [FNUserDefaults objectWithKey:@"historySkim"];
    if (historyS.count<2) return;
    FNNewsHotWordButton *btn = [[FNNewsHotWordButton alloc] init];
    FNNewsListItem *skimItem = [NSKeyedUnarchiver unarchiveObjectWithData:historyS[historyS.count-index]];
    NSString *wordStr = skimItem.title;
    
    btn.tag = index;
    [btn setTitle:wordStr forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setImage:[UIImage resizableImage:@"headex_button"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    CGSize wordSize  = [wordStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    CGSize labelSize = CGSizeMake(wordSize.width+20, wordSize.height+20);
    CGFloat wordX = 10;
    CGFloat wordY = 20 + (labelSize.height+15)*(index-1)+ 25;
    btn.frame = (CGRect){wordX, wordY, labelSize};
    
    [btn addTarget:self action:@selector(skimBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)skimBtnClick:(FNNewsHotWordButton *)btn
{
    NSArray *historyS = [FNUserDefaults objectWithKey:@"historySkim"];
    id item = [NSKeyedUnarchiver unarchiveObjectWithData:historyS[historyS.count-btn.tag]];

    if (self.historyBlock) {
        self.historyBlock(item);
    }
    
    
}
- (IBAction)moreButtonClick:(id)sender {
    if (self.moreBlock) {
        self.moreBlock();
    }
}
@end
