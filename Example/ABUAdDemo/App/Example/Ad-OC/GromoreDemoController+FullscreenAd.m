//
//  GromoreDemoController+FullscreenAd.m
//  ABUDemo
//
//  Created by heyinyin on 2022/2/14.
//  Copyright © 2022 bytedance. All rights reserved.
//
// 全屏视频广告加载Demo

/// Demo
#import "GromoreDemoController+FullscreenAd.h"
#import "GromoreDemoController+Ad.h"
#import <objc/runtime.h>
#import "ABUDMacros.h"

/// Gromore
#import "Gromore.h"

@interface GromoreDemoController () <ABUFullscreenVideoAdDelegate>

@end

@implementation GromoreDemoController (FullscreenVideoAd)

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadFullscreenVideoAdWithConfig:(GromoreAdLoadConfig *)config andParam:(GromoreAdLoadParam *)param {
    // 初始化广告加载对象
    self.fullscreenVideoAd = [[ABUFullscreenVideoAd alloc] initWithAdUnitID:config.slotID];
    // 配置：回调代理对象
    self.fullscreenVideoAd.delegate = self;
    // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUFullscreenVideoAd.h`文件
    // [可选]配置：静音
    self.fullscreenVideoAd.mutedIfCan = YES;
    // [可选]配置：设置奖励信息
    self.fullscreenVideoAd.rewardModel = ({
        ABURewardedVideoModel *model = [[ABURewardedVideoModel alloc] init];
        model.userId = @"xxxx";
        model.rewardName = @"金币";
        model.rewardAmount = 1000;
        model.extra = @"{}";
        model;
    });
    
    // 开始加载广告
    [self.fullscreenVideoAd loadAdData];
}

// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
- (void)showFullscreenVideoAd {
    [self.fullscreenVideoAd showAdFromRootViewController:self];
}

#pragma mark ----- ABUFullscreenVideoAdDelegate -----
/// 加载成功回调
- (void)fullscreenVideoAdDidLoad:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    
}

- (void)fullscreenVideoAdDidDownLoadVideo:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    
    
}

/// 加载失败回调
- (void)fullscreenVideoAd:(ABUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    
}

/// 展示成功回调
- (void)fullscreenVideoAdDidVisible:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    
    // 展示后可获取信息如下
    [self logFullscreenVideoAdInfoAfterShow];
}

- (void)fullscreenVideoAdDidShowFailed:(ABUFullscreenVideoAd *)fullscreenVideoAd error:(NSError *)error {
    
}

/// 广告点击回调
- (void)fullscreenVideoAdDidClick:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    
}

/// 广告关闭回调
- (void)fullscreenVideoAdDidClose:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    
}

- (void)fullscreenVideoAd:(ABUFullscreenVideoAd *)fullscreenVideoAd didPlayFinishWithError:(NSError *)error {
    
}

- (void)fullscreenVideoAdDidSkip:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    
}

- (void)fullscreenVideoAdServerRewardDidSucceed:(ABUFullscreenVideoAd *)fullscreenVideoAd rewardInfo:(ABUAdapterRewardAdInfo *)rewardInfo verify:(BOOL)verify {
    
    // 验证信息
    ABUD_Log(@"verify: %@", verify ? @"YES" : @"NO");
    ABUD_Log(@"platform: %@", [fullscreenVideoAd getShowEcpmInfo].adnName);
    ABUD_Log(@"reward name: %@", rewardInfo.rewardName);
    ABUD_Log(@"reward amount: %ld", rewardInfo.rewardAmount);
    ABUD_Log(@"trade id: %@", rewardInfo.tradeId ?: @"None");
}

#pragma mark ----- 可忽略 -----

- (void)resetFullscreenVideoAd {
    self.fullscreenVideoAd.delegate = nil;
    self.fullscreenVideoAd = nil;
}

- (void)logFullscreenVideoAdInfoAfterShow {
    // 展示后可获取信息如下
    ABUD_Log(@"%@", [self.fullscreenVideoAd getShowEcpmInfo]);
}

@end
