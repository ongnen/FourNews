//
//  FNNewsHotWordsListView.m
//  FourNews
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNNewsHotWordsListView.h"
#import "FNNewsHotWordButton.h"

@interface FNNewsHotWordsListView ()

@property (nonatomic, strong) NSMutableArray<FNNewsHotWordButton *> *BtnArray;

@end

@implementation FNNewsHotWordsListView

- (NSMutableArray *)BtnArray
{
    if (!_BtnArray){
        self.BtnArray = [[NSMutableArray alloc] init];
    }
    return _BtnArray;
    
}

- (void)setHotWords:(NSArray<FNNewsHotWordItem *> *)hotWords
{
    
    for (int i = 0; i<hotWords.count; i++) {
        FNNewsHotWordButton *hotWordBtn = [[FNNewsHotWordButton alloc] init];
        [self.BtnArray addObject:hotWordBtn];
        NSString *wordStr = hotWords[i].hotWord;
        [hotWordBtn setTitle:wordStr forState:UIControlStateNormal];
        hotWordBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [hotWordBtn setImage:[UIImage resizableImage:@"headex_button"] forState:UIControlStateNormal];
        [hotWordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        CGSize wordSize  = [wordStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        CGSize labelSize = CGSizeMake(wordSize.width+20, wordSize.height+20);
        CGFloat wordX;
        CGFloat wordY = 20 + (labelSize.height+15)*i + 25;
        if (i < 6) {
            wordX = 10;
        } else {
            wordX = CGRectGetMaxX(self.BtnArray[i-6].frame)+20;
            wordY = 20 + (labelSize.height+15)*(i-6) + 25;
        }
        
        
        hotWordBtn.frame = (CGRect){wordX, wordY, labelSize};
        [hotWordBtn addTarget:self action:@selector(hotWordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hotWordBtn];
    }
}

- (void)hotWordBtnClick:(FNNewsHotWordButton *)Btn
{
    
    if (self.hotWordBlock) {
        self.hotWordBlock(Btn.titleLabel.text);
    }
}




@end
