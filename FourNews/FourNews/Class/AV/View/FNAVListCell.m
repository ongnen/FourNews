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
@property (weak, nonatomic) IBOutlet UIView *playerV;
@property (nonatomic, weak) UIImageView *topicImgV;
@property (nonatomic, weak) UILabel *topicL;
@property (nonatomic, weak) UIView *topicView;
@property (nonatomic, weak) UILabel *timeAndPlayCountL;
@property (nonatomic, weak) UIView *marginV;
@property (nonatomic, weak) UIImageView *playImgV;


@end

@implementation FNAVListCell

- (void)awakeFromNib
{
    // 回复按钮
    UIButton *replyButton = [[UIButton alloc] init];
    [self.bottomBar addSubview:replyButton];
    _replyButton = replyButton;
    
    // 图片内部时间及播放次数Label
    UILabel *timeAndPlayCountL = [[UILabel alloc] init];
    timeAndPlayCountL.textColor = [UIColor whiteColor];
    timeAndPlayCountL.font = [UIFont systemFontOfSize:12];
    [self.coverImgV addSubview:timeAndPlayCountL];
    self.timeAndPlayCountL = timeAndPlayCountL;
    
    // 视频图片下方控件
    UIView *topicView = [[UIView alloc] init];
    
    UIImageView *topicImgV = [[UIImageView alloc] init];
    self.topicImgV = topicImgV;
    [topicView addSubview:topicImgV];
    
    UILabel *topicL = [[UILabel alloc] init];
    self.topicL = topicL;
    [topicView addSubview:topicL];
    
    [self.bottomBar addSubview:topicView];
    _topicView = topicView;
    
    // 分隔线
    UIView *marginV = [[UIView alloc] init];
    marginV.backgroundColor = FNCommonColor;
    [self addSubview:marginV];
    _marginV = marginV;
    
    // 播放按钮图片
    UIImageView *playImgV = [[UIImageView alloc] init];
    playImgV.image = [UIImage imageNamed:@"night_video_cell_play"];
    playImgV.bounds = CGRectMake(0, 0, 40, 40);
    playImgV.center = CGPointMake((FNScreenW-YJCommonMargin*2)/2, self.coverImgV.height/2);
    self.playImgV = playImgV;
    [self.coverImgV addSubview:playImgV];
    
    self.autoresizingMask = 0;
    
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
    
    // 设置分割线与分隔View
    self.marginV.frame = CGRectMake(0, 280, FNScreenW, YJMargin);
    
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
    self.coverImgV.hidden = NO;
    self.coverImgV.userInteractionEnabled = YES;
    [self.coverImgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    [self.coverImgV sd_setImageWithURL:[NSURL URLWithString:_listItem.cover] placeholderImage:[UIImage imageNamed:@"photosetBackGround"]];

    
    // 图片内部时间及播放次数Label
    NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d",[_listItem.length  intValue]/60,[_listItem.length  intValue]%60];
    
    NSString *playCountStr = [NSString stringWithFormat:@"%ld播放",_listItem.playCount];
    if (_listItem.playCount >9999) {
        playCountStr =  [NSString stringWithFormat:@"%0.1f万播放",_listItem.playCount/10000.0];
    }
    NSString *timeAndPlayCountStr = [NSString stringWithFormat:@"%@/%@",timeStr,playCountStr];
    self.timeAndPlayCountL.text = timeAndPlayCountStr;
    CGSize timeAndPlayCountSize = [timeAndPlayCountStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    self.timeAndPlayCountL.frame = CGRectMake(FNScreenW-16-timeAndPlayCountSize.width-YJMargin, 180-timeAndPlayCountSize.height-YJMargin, timeAndPlayCountSize.width, timeAndPlayCountSize.height);
}

- (void)coverClick
{
    _coverImgV.hidden = YES;
    if (self.movieBlock) {
        self.movieBlock(_listItem.mp4_url,_playerV);
    }
}

- (void)setBottomBar
{
    [self.replyButton setImage:[UIImage imageNamed:@"pluginmanager_icon_message"] forState:UIControlStateNormal];
    [self.replyButton setImage:[UIImage imageNamed:@"pluginmanager_icon_message"] forState:UIControlStateHighlighted];
    NSString *replyCount = [NSString stringWithFormat:@"%@",_listItem.replyCount];
    [self.replyButton addTarget:self action:@selector(replyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.replyButton setTitle:replyCount forState:UIControlStateNormal];
    [self.replyButton setTitleColor:FNColor(150, 150, 150) forState:UIControlStateNormal];
    [self.replyButton setTitleColor:FNColor(150, 150, 150) forState:UIControlStateHighlighted];
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
        self.replyBlock(_listItem);
    }
}

+ (CGFloat)totalHeightWithTitle:(NSString *)title
{
    CGFloat titleLH = [title boundingRectWithSize:CGSizeMake(FNScreenW-YJCommonMargin*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
                         
    return 180+40+8*4+titleLH;
}

@end
