//
//  BUDMacros.h
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/10/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#ifndef ABUDMacros_h
#define ABUDMacros_h

#define mainColor                 kABUD_RGB(0xff, 0x63, 0x5c)
#define unValidColor              kABUD_RGB(0xd7, 0xd7, 0xd7)
#define titleBGColor              kABUD_RGB(73, 15, 15)
#define selectedColor             [UIColor colorWithRed:(73 / 255.0) green:(15 / 255.0) blue:(15 / 255.0) alpha:0.8]
#define kABUD_RGB(r, g, b) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1]
/// iphone X、XR、XS、XS Max适配
#ifndef kABUDMINScreenSide
#define kABUDMINScreenSide        MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#ifndef kABUDMAXScreenSide
#define kABUDMAXScreenSide        MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#define kABUDiPhoneX              ((kABUDMAXScreenSide == 812.0) || (kABUDMAXScreenSide == 896))
#define kABUNavigationBarHeight   (kABUDiPhoneX ? 88 : 64)  // 导航条高度
#define kABUTopMargin             (kABUDiPhoneX ? 24 : 0)
#define kABUBottomMargin          (kABUDiPhoneX ? 40 : 0) // 状态栏高度

#define ABUD_Log(frmt, ...)   \
    do {                                                      \
        NSLog(@"【ABUAdSDK_V%@_Demo】%@", [ABUAdSDKManager SDKVersion], [NSString stringWithFormat:frmt, ## __VA_ARGS__]);  \
    } while(0)

#define ABUD_LogCallback(frmt, ...)   \
    do {                                                      \
        NSLog(@"【ABUAdSDK_V%@_Demo_Callback】%@", [ABUAdSDKManager SDKVersion], [NSString stringWithFormat:frmt, ## __VA_ARGS__]);  \
    } while(0)

#ifndef kABUDNativeAdTranslateKey
#define kABUDNativeAdTranslateKey @"abu_nativeAd"
#endif

#endif /* BUDMacros_h */
