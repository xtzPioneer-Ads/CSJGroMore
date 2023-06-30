//
//  GromoreDemoController+InterstitialAd.m
//  ABUDemo
//
//  Created by bytedance on 2022/2/10.
//  Copyright © 2022 bytedance. All rights reserved.
//
// 插屏广告加载Demo

/// Demo
#import "GromoreDemoController+InterstitialAd.h"
#import "GromoreDemoController+Ad.h"
#import <objc/runtime.h>
#import "ABUDMacros.h"

/// Gromore
#import "Gromore.h"

@interface GromoreDemoController () <ABUInterstitialAdDelegate>

@end

@implementation GromoreDemoController (InterstitialAd)

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadInterstitialAdWithConfig:(GromoreAdLoadConfig *)config andParam:(GromoreAdLoadParam *)param {
    
    // 初始化广告加载对象
    self.interstitialAd = [[ABUInterstitialAd alloc] initWithAdUnitID:config.slotID size:(CGSize){300, 300 * 3 / 2}];
    // 配置：回调代理对象
    self.interstitialAd.delegate = self;
    // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUInterstitialAd.h`文件
    // [可选]配置：静音
    self.interstitialAd.mutedIfCan = YES;
    
    // 开始加载广告
    [self.interstitialAd loadAdData];
}

// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
- (void)showInterstitialAd {
    [self.interstitialAd showAdFromRootViewController:self];
}

#pragma mark ----- ABUInterstitialAdDelegate -----
/// 加载成功回调
- (void)interstitialAdDidLoad:(ABUInterstitialAd *)interstitialAd {
    
}

/// 加载失败回调
- (void)interstitialAd:(ABUInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    
}

- (void)interstitialAdViewRenderFail:(ABUInterstitialAd *)interstitialAd error:(NSError *)error {
    
}

/// 展示成功回调
- (void)interstitialAdDidVisible:(ABUInterstitialAd *)interstitialAd {
    
    [self logInterstitialAdInfoAfterShow];
}

- (void)interstitialAdDidShowFailed:(ABUInterstitialAd *)interstitialAd error:(NSError *)error {
    
}

/// 广告点击回调
- (void)interstitialAdDidClick:(ABUInterstitialAd *)interstitialAd {
    
}

/// 广告关闭回调
- (void)interstitialAdDidClose:(ABUInterstitialAd *)interstitialAd {
    
}

#pragma mark ----- 可忽略 -----

- (void)resetInterstitialAd {
    self.interstitialAd.delegate = nil;
    self.interstitialAd = nil;
}

- (void)logInterstitialAdInfoAfterShow {
    // 展示后可获取信息如下
    ABUD_Log(@"%@", [self.interstitialAd getShowEcpmInfo]);
}
@end
