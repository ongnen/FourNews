//
//  Common.h
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

/*
 存放公共的宏
*/
#ifndef Common_h
#define Common_h

#define FNColor(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]
#define FNColorAlpha(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]

#define FNScreenW [UIScreen mainScreen].bounds.size.width

#define FNScreenH [UIScreen mainScreen].bounds.size.height

#define FNBottomBarHeight 49
#define FNTopBarHeight 64
#define FNStateBarHeight 20
#define FNADCellHeight 200

#endif /* Common_h */
