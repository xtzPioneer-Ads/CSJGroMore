//
//  GromoreDemoController+SplashAd.m
//  ABUDemo
//
//  Created by heyinyin on 2022/2/14.
//  Copyright © 2022 bytedance. All rights reserved.
//
// Splash广告加载Demo

/// Demo
#import "GromoreDemoController+SplashAd.h"
#import "GromoreDemoController+Ad.h"
#import <objc/runtime.h>
#import "ABUDMacros.h"

/// Gromore
#import "Gromore.h"

@interface GromoreDemoController () <ABUSplashAdDelegate, ABUZoomOutSplashAdDelegate>

@end

@implementation GromoreDemoController (SplashAd)

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadSplashAdWithConfig:(GromoreAdLoadConfig *)config andParam:(GromoreAdLoadParam *)param {
    
    // 初始化广告加载对象
    self.splashAd = [[ABUSplashAd alloc] initWithAdUnitID:config.slotID];
    // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUSplashAd.h`文件
    // 配置：跳转控制器
    self.splashAd.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    // 配置：回调代理对象
    self.splashAd.delegate = self;
    // [可选]配置：是否开启点睛功能，默认不开启
    self.splashAd.needZoomOutIfCan = YES;
    // [可选]配置：是否展示卡片视图，默认不开启，仅支持穿山甲广告
    self.splashAd.supportCardView = YES;
    // [可选]配置：自定义底部视图，可以设置LOGO等，仅部分ADN支持
    self.splashAd.customBottomView = ({
        UILabel *view = [[UILabel alloc] init];
        view.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
        view.backgroundColor = [UIColor redColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.text = @"这是一个展示在广告底部的视图";
        view;
    });
    // [可选]配置：兜底方案，在配置拉取失败时会按照该方案进行广告加载
    [self.splashAd setUserData:({
            ABUSplashUserData *userData = [[ABUSplashUserData alloc] init];
            userData.adnName = @"pangle"; // ADN的名字，pangle为穿山甲，更多ADN请查看ABUSplashUserData头文件
            userData.rit = @""; // 代码位ID，即ADN的广告位ID
            userData.appID = @""; // ADN的appID，在ADN后台查看，与在GroMore后台配置应保持一致
            userData.appKey = nil; // ADN的appKey，在ADN后台查看，仅个别ADN支持，没有就不用传
            userData;
    }) error:NULL];
    
    // 开始加载广告
    [self.splashAd loadAdData];
}

// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
- (void)showSplashAd {
    [self.splashAd showInWindow:[UIApplication sharedApplication].keyWindow];
}

#pragma mark ----- ABUSplashAdDelegate -----
/// 加载成功回调
- (void)splashAdDidLoad:(ABUSplashAd *)splashAd {
    // 处理开屏点睛
    if (splashAd.zoomOutView && splashAd.zoomOutView.addOccasionType == ABUAddOccasionTypeWhenLoad) {
        [self _showZoomOutView];
    }
}

/// 加载失败回调
- (void)splashAd:(ABUSplashAd *)splashAd didFailWithError:(NSError *)error {
    
}

/// 展示成功回调
- (void)splashAdWillVisible:(ABUSplashAd *)splashAd {
    
    // 展示后可获取信息如下
    [self logSplashAdInfoAfterShow];
}

- (void)splashAdDidShowFailed:(ABUSplashAd *)splashAd error:(NSError *)error {
    
}

/// 广告点击回调
- (void)splashAdDidClick:(ABUSplashAd *)splashAd {
    
}

/// 广告关闭回调
- (void)splashAdDidClose:(ABUSplashAd *)splashAd {
    // 命中开屏点睛
    if (splashAd.zoomOutView && splashAd.zoomOutView.addOccasionType == ABUAddOccasionTypeWhenClose) {
        // 处理收缩的开屏点睛View
        [self _showZoomOutView];
    } else {
        // 非开屏zoomout在此销毁
        [splashAd destoryAd];
    }
}

#pragma mark - ABUZoomOutSplashAdDelegate && Support

- (void)splashZoomOutViewAdDidClick:(UIView *_Nonnull)splashZoomOutView {
    
}

- (void)splashZoomOutViewAdDidClose:(UIView *_Nonnull)splashZoomOutView {
    
}

- (void)splashZoomOutViewAdDidPresentFullScreenModal:(UIView *_Nonnull)splashZoomOutView {
    
}

- (void)splashZoomOutViewAdDidDismissFullScreenModal:(UIView *_Nonnull)splashZoomOutView {
    
}

- (void)_showZoomOutView {
    // Required 设置delegate
    self.splashAd.zoomOutView.delegate = self;
    // Required设置zoomOutView的根vc，不设置默认和splashAd的一致;!!!若要更改该设置，必须在splashAdshow之后进行赋值
//    self.splashAd.zoomOutView.rootViewController = self;
    // Required 将zoomout view添加到视图
    [self.view addSubview:self.splashAd.zoomOutView];

    // Required size值时为SDK给定的建议值或比例(且最小不得小于suggestedSize)
    CGSize zoomoutSize = CGSizeMake(200, 420);
    if (self.splashAd.zoomOutView.suggestedSize.width > 0 &&
        self.splashAd.zoomOutView.suggestedSize.height > 0) {
        // 可使用sdk建议的大小
        zoomoutSize = self.splashAd.zoomOutView.suggestedSize;
        // 也可按size比例自定义大小
//        zoomoutSize.height = zoomoutSize.width * self.splashAd.zoomOutView.suggestedSize.height / self.splashAd.zoomOutView.suggestedSize.width;
    }

    CGRect rect = CGRectMake(414 - zoomoutSize.width - 60, 818 - zoomoutSize.height - 60, zoomoutSize.width, zoomoutSize.height);
    // 若adn的开屏点睛没有自带动画，开发者可按实际情况自行实现动画
    if (!self.splashAd.zoomOutView.hasAnimation) {
        // 简单动画示例，开发者亦可自行实现更好的动画效果
        [UIView transitionWithView:self.splashAd.zoomOutView duration:0.25 options:UIViewAnimationOptionCurveEaseOut animations:^{
    //         origin位置按需设置
            self.splashAd.zoomOutView.frame = rect;
        } completion:nil];
    } else {
        // origin位置按需设置
        self.splashAd.zoomOutView.frame = rect;
    }
}

#pragma mark ----- 可忽略 -----
- (void)resetSplashAd {
    self.splashAd.delegate = nil;
    self.splashAd = nil;
}

- (void)logSplashAdInfoAfterShow {
    // 展示后可获取信息如下
    ABUD_Log(@"%@", [self.splashAd getShowEcpmInfo]);
}
@end
