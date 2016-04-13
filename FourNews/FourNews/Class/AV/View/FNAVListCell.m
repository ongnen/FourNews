//
//  FNAVListCell.m
//  FourNews
//
//  Created by admin on 16/4/10.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVListCell.h"
#import <UIImageView+WebCache.h>
#define FNAVTopicImgWH 24


@interface FNAVListCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *coverImgV;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (nonatomic, weak) UIImageView *topicImgV;
@property (nonatomic, weak) UILabel *topicL;
@property (nonatomic, weak) UIView *topicView;


@end

@implementation FNAVListCell

- (UIButton *)replyButton
{
    if (!_replyButton){
        UIButton *replyButton = [[UIButton alloc] init];
        [self.bottomBar addSubview:replyButton];
        _replyButton = replyButton;
    }
    return _replyButton;
    
}

- (UIView *)topicView
{
    if (!_topicView){
        UIView *topicView = [[UIView alloc] init];
        
        UIImageView *topicImgV = [[UIImageView alloc] init];
        self.topicImgV = topicImgV;
        [topicView addSubview:topicImgV];
        
        UILabel *topicL = [[UILabel alloc] init];
        self.topicL = topicL;
        [topicView addSubview:topicL];
        
        [self.bottomBar addSubview:topicView];
        _topicView = topicView;
    }
    return _topicView;
    
}



- (void)setListItem:(FNAVListItem *)listItem
{
    _listItem = listItem;
    // 设置标题
    [self setupTitleL];
    // 设置视频图片
    [self setupCoverImgV];
    // 设置底部条
    [self setBottomBar];
    
    
}
#pragma mark - 设置标题
- (void)setupTitleL
{
    self.titleL.text = _listItem.title;
    self.titleL.font = [UIFont systemFontOfSize:17];
    self.titleL.textColor = [UIColor blackColor];
    self.titleL.numberOfLines = 0;
    CGSize titleLSize = [_listItem.title boundingRectWithSize:CGSizeMake(FNScreenW-YJCommonMargin*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self.titleHeightConstraint.constant = titleLSize.height+FNCompensate(5);
}
#pragma mark - 设置视频图片
- (void)setupCoverImgV
{
    self.coverImgV.userInteractionEnabled = YES;
    [self.coverImgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    [self.coverImgV sd_setImageWithURL:[NSURL URLWithString:_listItem.cover] placeholderImage:[UIImage imageNamed:@"photosetBackGround"]];
    
    UIImageView *playImgV = [[UIImageView alloc] init];
    playImgV.image = [UIImage imageNamed:@"night_video_cell_play"];
    playImgV.bounds = CGRectMake(0, 0, 40, 40);
    
    playImgV.center = CGPointMake((FNScreenW-YJCommonMargin*2)/2, self.coverImgV.height/2);
    [self.coverImgV addSubview:playImgV];
}

- (void)coverClick
{
    if (self.movieBlock) {
        self.movieBlock(_listItem.mp4_url);
    }
}

- (void)setBottomBar
{
    [self.replyButton setImage:[UIImage imageNamed:@"pluginmanager_icon_message"] forState:UIControlStateNormal];
    NSString *replyCount = [NSString stringWithFormat:@"%@",_listItem.replyCount];
    [self.replyButton addTarget:self action:@selector(replyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.replyButton setTitle:replyCount forState:UIControlStateNormal];
    [self.replyButton setTitleColor:FNColor(150, 150, 150) forState:UIControlStateNormal];
    self.replyButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.replyButton sizeToFit];
    self.replyButton.origin = CGPointMake(FNScreenW-FNCompensate(40)-YJCommonMargin*2-self.replyButton.width, 0);
    
    
    self.topicView.backgroundColor = FNColor(230, 230, 230);
    CGFloat topicW = [_listItem.topicName sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:12]}].width;
    self.topicView.layer.cornerRadius = FNAVTopicImgWH/2;
    self.topicView.clipsToBounds = YES;
    self.topicView.frame = CGRectMake(0, FNCompensate(6), topicW+FNAVTopicImgWH+FNCompensate(10), FNAVTopicImgWH);
    
    [self.topicImgV sd_setImageWithURL:[NSURL URLWithString:_listItem.topicImg] placeholderImage:[UIImage imageNamed:@"tabbar_icon_me_normal"]];
    self.topicImgV.frame = CGRectMake(0, 0, 24, 24);
    self.topicImgV.layer.cornerRadius = 12;
    self.topicImgV.clipsToBounds = YES;
    
    self.topicL.textColor = [UIColor blackColor];
    self.topicL.font = [UIFont systemFontOfSize:12];
    self.topicL.text = _listItem.topicName;
    self.topicL.frame = CGRectMake(self.topicImgV.width + FNCompensate(5), 0, topicW, FNAVTopicImgWH);
}

- (void)replyBtnClick
{
    if (self.replyBlock) {
        self.replyBlock(_listItem.replyBoard,_listItem.replyid);
    }
}

+ (CGFloat)totalHeightWithTitle:(NSString *)title
{
    CGFloat titleLH = [title boundingRectWithSize:CGSizeMake(FNScreenW-YJCommonMargin*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
                         
    return 180+40+8*4+titleLH;
}

@end
