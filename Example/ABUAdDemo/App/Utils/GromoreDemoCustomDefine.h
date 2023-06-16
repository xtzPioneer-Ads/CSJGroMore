//
//  ABUDemoCustomDefine.h
//  Ads-Mediation-CN-demo
//
//  Created by heyinyin on 2021/12/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define GROMOREColor(r,g,b) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]

#pragma mark ------ color ------
#define GROMORE_338AFF_Color GROMOREColor(51,138,255) /// 蓝色
#define GROMORE_666666_Color GROMOREColor(102,102,102) /// 近黑色
#define GROMORE_333333_Color GROMOREColor(51,51,51)

#pragma mark ------ font ------
#define GROMORE_PingFangSC_Font(_fontSize_) [UIFont fontWithName:@"PingFang SC" size:_fontSize_]
#define GROMORE_PingFangSC_Semibold_Font(_fontSize_) [UIFont fontWithName:@"PingFangSC-Semibold" size:_fontSize_]

NS_ASSUME_NONNULL_END
