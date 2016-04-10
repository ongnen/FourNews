//
//  FNNewsPhotoSetItem.h
//  FourNews
//
//  Created by admin on 16/4/5.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNNewsPhotoSetItem : NSObject
// 发布时间
@property (nonatomic, strong) NSString *datatime;
// 作者
@property (nonatomic, strong) NSString *creator;
// 来源
@property (nonatomic, strong) NSString *source;
// 图片url
@property (nonatomic, strong) NSString *imgurl;
// 图片描述
@property (nonatomic, strong) NSString *imgtitle;
// 图片描述
@property (nonatomic, strong) NSString *note;
// 图集描述
@property (nonatomic, strong) NSString *setname;


@end
