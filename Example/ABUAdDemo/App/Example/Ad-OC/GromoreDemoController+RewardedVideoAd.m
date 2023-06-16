//
//  GromoreDemoController+RewardedVideoAd.m
//  ABUDemo
//
//  Created by heyinyin on 2022/2/14.
//  Copyright © 2022 bytedance. All rights reserved.
//
// 激励视频广告加载Demo

/// Demo
#import "GromoreDemoController+RewardedVideoAd.h"
#import "GromoreDemoController+Ad.h"
#import <objc/runtime.h>
#import "ABUDMacros.h"

/// Gromore
#import "Gromore.h"

@interface GromoreDemoController () <ABURewardedVideoAdDelegate>

@end

@implementation GromoreDemoController (RewardedVideoAd)

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadRewardedVideoAdWithConfig:(GromoreAdLoadConfig *)config andParam:(GromoreAdLoadParam *)param {
    // 初始化广告加载对象
    self.rewardedVideoAd = [[ABURewardedVideoAd alloc] initWithAdUnitID:config.slotID];
    // 配置：回调代理对象
    self.rewardedVideoAd.delegate = self;
    // [可选]配置：激励再得的回调
    self.rewardedVideoAd.rewardPlayAgainDelegate = self;
    // [可选]配置：设置是否静音
    self.rewardedVideoAd.mutedIfCan = YES;
    // [可选]配置：设置奖励信息
    self.rewardedVideoAd.rewardedVideoModel = ({
        ABURewardedVideoModel *model = [[ABURewardedVideoModel alloc] init];
        model.userId = @"xxxx";
        model.rewardName = @"金币";
        model.rewardAmount = 1000;
        model.extra = @"{}";
        model;
    });
    
    // 开始加载广告
    [self.rewardedVideoAd loadAdData];
}

// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法，需在广告加载完成之后调用
- (void)showRewardedVideoAd {
    [self.rewardedVideoAd showAdFromRootViewController:self];
}

#pragma mark ----- ABURewardedVideoAdDelegate -----
// 加载成功回调
- (void)rewardedVideoAdDidLoad:(ABURewardedVideoAd *)rewardedVideoAd {
    
}

- (void)rewardedVideoAdDidDownLoadVideo:(ABURewardedVideoAd *)rewardedVideoAd {
    
}

// 加载失败回调
- (void)rewardedVideoAd:(ABURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    
}

// 展示成功回调
- (void)rewardedVideoAdDidVisible:(ABURewardedVideoAd *)rewardedVideoAd {
    // 展示后可获取信息如下
    [self logAdInfoAfterShow];
}

- (void)rewardedVideoAdDidShowFailed:(ABURewardedVideoAd *)rewardedVideoAd error:(NSError *)error {
    
}

// 广告点击回调
- (void)rewardedVideoAdDidClick:(ABURewardedVideoAd *)rewardedVideoAd {
    
}

// 广告关闭回调
- (void)rewardedVideoAdDidClose:(ABURewardedVideoAd *)rewardedVideoAd {
    
}

- (void)rewardedVideoAd:(ABURewardedVideoAd *)rewardedVideoAd didPlayFinishWithError:(NSError *)error {
    
}

- (void)rewardedVideoAdDidSkip:(ABURewardedVideoAd *)rewardedVideoAd {
    
}

// 奖励验证回调
- (void)rewardedVideoAdServerRewardDidSucceed:(ABURewardedVideoAd *)rewardedVideoAd rewardInfo:(ABUAdapterRewardAdInfo *)rewardInfo verify:(BOOL)verify {
    // 验证信息
    ABUD_Log(@"verify: %@", verify ? @"YES" : @"NO");
    ABUD_Log(@"platform: %@", [rewardedVideoAd getShowEcpmInfo].adnName);
    ABUD_Log(@"reward name: %@", rewardInfo.rewardName);
    ABUD_Log(@"reward amount: %ld", rewardInfo.rewardAmount);
    ABUD_Log(@"trade id: %@", rewardInfo.tradeId ?: @"None");
}

#pragma mark ----- 可忽略 -----

- (void)resetRewardedVideoAd {
    self.rewardedVideoAd.delegate = nil;
    self.rewardedVideoAd = nil;
}

- (void)logAdInfoAfterShow {
    // 展示后可获取信息如下
    ABUD_Log(@"%@", [self.rewardedVideoAd getShowEcpmInfo]);
}

@end
