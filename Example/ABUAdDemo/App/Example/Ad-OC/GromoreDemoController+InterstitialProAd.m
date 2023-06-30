//
//  GromoreDemoController+InterstitialProAd.m
//  ABUDemo
//
//  Created by heyinyin on 2022/2/14.
//  Copyright © 2022 bytedance. All rights reserved.
//
// 插全屏广告加载Demo

/// Demo
#import "GromoreDemoController+InterstitialProAd.h"
#import "GromoreDemoController+Ad.h"
#import <objc/runtime.h>
#import "ABUDMacros.h"

/// Gromore
#import "Gromore.h"

@interface GromoreDemoController () <ABUInterstitialProAdDelegate>

@end

@implementation GromoreDemoController (InterstitialProAd)

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadInterstitialProAdWithConfig:(GromoreAdLoadConfig *)config andParam:(GromoreAdLoadParam *)param {
    // 初始化广告加载对象
    self.interstitialProAd = [[ABUInterstitialProAd alloc] initWithAdUnitID:config.slotID sizeForInterstitial:(CGSize){300, 300 * 3 / 2}];
    // 配置：回调代理对象
    self.interstitialProAd.delegate = self;
    // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUInterstitialProAd.h`文件
    // [可选]配置：静音
    self.interstitialProAd.mutedIfCan = YES;
    // [可选]配置：设置奖励信息
    self.interstitialProAd.rewardModel = ({
        ABURewardedVideoModel *model = [[ABURewardedVideoModel alloc] init];
        model.userId = @"xxxx";
        model.rewardName = @"金币";
        model.rewardAmount = 1000;
        model.extra = @"{}";
        model;
    });
    
    // 开始加载广告
    [self.interstitialProAd loadAdData];
}

// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
- (void)showInterstitialProAd {
    [self.interstitialProAd showAdFromRootViewController:self extraInfos:nil];
}

#pragma mark ----- ABUInterstitialProAdDelegate -----
/// 加载成功回调
- (void)interstitialProAdDidLoad:(ABUInterstitialProAd *)interstitialProAd {
    
}

- (void)interstitialProAdDidDownLoadVideo:(ABUInterstitialProAd *)interstitialProAd {
    
}

/// 加载失败回调
- (void)interstitialProAd:(ABUInterstitialProAd *)interstitialProAd didFailWithError:(NSError *)error {
    
}

/// 展示成功回调
- (void)interstitialProAdDidVisible:(ABUInterstitialProAd *)interstitialProAd {
    
    // 展示后可获取信息如下
    [self logInterstitialProAdInfoAfterShow];
}

- (void)interstitialProAdDidShowFailed:(ABUInterstitialProAd *)interstitialProAd error:(NSError *)error {
    
}

- (void)interstitialProAdDidPlayFinish:(ABUInterstitialProAd *)interstitialProAd didFailWithError:(NSError *)error {
    
}

/// 广告点击回调
- (void)interstitialProAdDidClick:(ABUInterstitialProAd *)interstitialProAd {
    
}

/// 广告关闭回调
- (void)interstitialProAdDidClose:(ABUInterstitialProAd *)interstitialProAd {
    
}

// 奖励验证回调
- (void)interstitialProAdServerRewardDidSucceed:(ABUInterstitialProAd *)interstitialProAd rewardInfo:(ABUAdapterRewardAdInfo *)rewardInfo verify:(BOOL)verify {
    
    // 验证信息
    ABUD_Log(@"verify: %@", verify ? @"YES" : @"NO");
    ABUD_Log(@"platform: %@", [interstitialProAd getShowEcpmInfo].adnName);
    ABUD_Log(@"reward name: %@", rewardInfo.rewardName);
    ABUD_Log(@"reward amount: %ld", rewardInfo.rewardAmount);
    ABUD_Log(@"trade id: %@", rewardInfo.tradeId ?: @"None");
}

#pragma mark ----- 可忽略 -----

- (void)resetInterstitialProAd {
    self.interstitialProAd.delegate = nil;
    self.interstitialProAd = nil;
}

- (void)logInterstitialProAdInfoAfterShow {
    // 展示后可获取信息如下
    ABUD_Log(@"%@", [self.interstitialProAd getShowEcpmInfo]);
}
@end
