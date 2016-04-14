//
//  FNReadGetNewsListItem.m
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNReadGetNewsListItem.h"
#import "FNReadListItem.h"
#import <MJExtension.h>


@implementation FNReadGetNewsListItem

+ (void)getNewsListItemsWithCount:(NSInteger)count :(void (^)(NSArray *))complete
{
    NSString *str = [NSString stringWithFormat:@"http://c.3g.163.com/recommend/getSubDocPic?from=yuedu&passport=&devId=MXMBjPFGwQtsVvvyqiU4T%%2FwBdkQM4meyMjoBvP7QRADOvWNXF4MglqFoOcM%%2Fy4na&size=yingjie0&version=5.6.0&spever=false&net=wifi&lat=&lon=&ts=1460206079&sign=OSD0%%2FJHZ9TcMrgys4VRhqKQkwU5u9%%2Fv0n4Dzzr8TzIl48ErR02zJ6%%2FKXOnxX046I&encryption=1&canal=appstore"];
    NSString *urlStr = [str stringByReplacingOccurrencesOfString:@"yingjie" withString:[NSString stringWithFormat:@"%ld",count]];
    [FNNetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        NSArray *items = [FNReadListItem mj_objectArrayWithKeyValuesArray:responseObject[@"推荐"]];
        complete(items);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

@end
