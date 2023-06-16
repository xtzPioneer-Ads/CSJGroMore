//
//  GromoreDemoController+ad.h
//  ABUDemoSwift
//
//  Created by heyinyin on 2022/6/8.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "GromoreDemoController.h"
/// Gromore
#import "GroMore.h"

NS_ASSUME_NONNULL_BEGIN

@interface GromoreDemoController ()

@property (nonatomic, strong, nullable) ABUBannerAd *bannerAd;

@property (nonatomic, strong, nullable) ABUInterstitialAd *interstitialAd;

@property (nonatomic, strong, nullable) ABUInterstitialProAd *interstitialProAd;

@property (nonatomic, strong, nullable) ABUSplashAd *splashAd;

@property (nonatomic, strong, nullable) ABURewardedVideoAd *rewardedVideoAd;

@property (nonatomic, strong, nullable) ABUDrawAdsManager *drawAd;

@property (nonatomic, strong, nullable) ABUNativeAdsManager *nativeAd;

@property (nonatomic, strong, nullable) ABUFullscreenVideoAd *fullscreenVideoAd;

@property (nonatomic, strong, nullable) ABUNativeAdView *nativeAdView;

@property (nonatomic, strong, nullable) ABUDrawAdView *drawAdView;

@end

NS_ASSUME_NONNULL_END
