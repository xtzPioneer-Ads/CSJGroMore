//
//  GromoreAdLoadConfig.m
//  ABUDemo
//
//  Created by bytedance on 2022/2/10.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "GromoreAdLoadConfig.h"

@implementation GromoreAdLoadConfig

- (NSString *)adTypeName {
    static NSDictionary *dict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = @{
            @(GromoreAdTypeBanner) : @"Banner",
            @(GromoreAdTypeInterstitial) : @"Interstitial",
            @(GromoreAdTypeSplash) : @"Splash",
            @(GromoreAdTypeNative) : @"Native",
            @(GromoreAdTypeRewardedVideo) : @"RewardedVideo",
            @(GromoreAdTypeFullscreenVideo) : @"FullscreenVideo",
            @(GromoreAdTypeInterstitialPro) : @"InterstitialPro",
            @(GromoreAdTypeDraw) : @"Draw",
        };
    });
    return dict[@(self.adType)];
}

@end
