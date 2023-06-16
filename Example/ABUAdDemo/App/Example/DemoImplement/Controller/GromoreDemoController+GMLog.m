//
//  GromoreDemoController+GMLog.m
//  ABUDemo
//
//  Created by bytedance on 2022/2/15.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "GromoreDemoController+GMLog.h"
#import "GroMore.h"
#import "GromoreDemoAdStatusCell.h"

@implementation GromoreDemoController (GMLog)

- (NSArray<Protocol *> *)logMethodsInProtocols {
    return @[
        @protocol(ABUBannerAdDelegate),
        @protocol(ABUInterstitialAdDelegate),
        @protocol(ABUSplashAdDelegate),
        @protocol(ABURewardedVideoAdDelegate),
        @protocol(ABUFullscreenVideoAdDelegate),
        @protocol(ABUInterstitialProAdDelegate),
        @protocol(ABUNativeAdsManagerDelegate),
        @protocol(ABUNativeAdViewDelegate),
        @protocol(ABUNativeAdVideoDelegate),
        @protocol(ABUDrawAdsManagerDelegate),
        @protocol(ABUDrawAdViewDelegate),
        @protocol(ABUDrawAdVideoDelegate)
    ];
}

- (BOOL)prepareLogForMethod:(Method)method {
    return gromore_register_method(self.class, method);
}

- (NSString *)willLogInvocation:(GMInvocation *)invocation andMessage:(NSString *)message {
    
    if ([message containsString:@"DidLoad"] || [message containsString:@"SuccessToLoad"]) {
        [self loadedExtra];
    } else if ([message containsString:@"FailWithError:"]) {
        [self loadFailedExtra];
    } else if ([message containsString:@"DidClose"]) {
        [self closeExtra];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GromoreDemoAdStatusCellReviceRecordNotification object:nil userInfo:@{
         GromoreDemoAdStatusCellReviceRecordKey: message,
    }];
    return [NSString stringWithFormat:@"[%@]%@", [ABUAdSDKManager SDKVersion], message];
}

@end
