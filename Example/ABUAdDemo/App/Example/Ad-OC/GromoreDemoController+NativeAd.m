//
//  GromoreDemoController+NativeAd.m
//  ABUDemo
//
//  Created by bytedance on 2022/2/11.
//  Copyright © 2022 bytedance. All rights reserved.
//
// 信息流广告加载Demo

/// Demo
#import "GromoreDemoController+NativeAd.h"
#import "GromoreDemoController+Ad.h"
#import <objc/runtime.h>
#import "ABUDMacros.h"

/// Gromore
#import "ABUNativeAdView+CustomRender.h"

@interface GromoreDemoController ()
<ABUNativeAdsManagerDelegate, ABUNativeAdViewDelegate, ABUNativeAdVideoDelegate>

@end

@implementation GromoreDemoController (NativeAd)

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadNativeAdWithConfig:(GromoreAdLoadConfig *)config andParam:(GromoreAdLoadParam *)param {
    // 初始化广告加载对象
    self.nativeAd = [[ABUNativeAdsManager alloc] initWithAdUnitID:config.slotID adSize:config.adSize];
    // 配置：跳转控制器
    self.nativeAd.rootViewController = self;
    // 配置：回调代理对象
    self.nativeAd.delegate = self;
    // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUNativeAdsManager.h`文件
    // [可选]配置：摇一摇视图配置
    [self.nativeAd addParam:@(CGRectMake(0, 0, 200, 100)) withKey:ABUAdLoadingParamNAExpectShakeViewFrame];
    // [可选]配置：静音
    self.nativeAd.startMutedIfCan = YES;
    
    // 开始加载广告
    [self.nativeAd loadAdData];
}

// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
- (void)showNativeAd {
    [self showAdView:^UIView *(CGSize size) {
        self.nativeAdView.frame = (CGRect){CGPointZero, size};
        if (self.nativeAdView.isExpressAd) {
            // 模板广告：使用ADN的渲染方法进行渲染
            [self.nativeAdView render];
        } else {
            // 自渲染广告：开发者需自行渲染
            [self.nativeAdView customRender];
        }
        return self.nativeAdView;
    }];
}

#pragma mark ----- ABUNativeAdsManagerDelegate -----
/// 加载成功回调
- (void)nativeAdsManagerSuccessToLoad:(ABUNativeAdsManager *)adsManager nativeAds:(NSArray<ABUNativeAdView *> *)nativeAdViewArray {
    
    // view取值,⚠️ 请慎重
    self.nativeAdView = nativeAdViewArray.firstObject;
    
    // 重点:务必设定后续回调代理
    self.nativeAdView.delegate = self;
    self.nativeAdView.videoDelegate = self;
}

/// 加载失败回调
- (void)nativeAdsManager:(ABUNativeAdsManager *)adsManager didFailWithError:(NSError *)error {
    
}

#pragma mark - ABUNativeAdViewDelegate
- (void)nativeAdExpressViewRenderSuccess:(ABUNativeAdView *_Nonnull)nativeExpressAdView {

}

- (void)nativeAdExpressViewRenderFail:(ABUNativeAdView *_Nonnull)nativeExpressAdView error:(NSError *_Nullable)error {
    
}

/// 展示成功回调
- (void)nativeAdDidBecomeVisible:(ABUNativeAdView *_Nonnull)nativeAdView {
    
    // 展示后可获取信息如下
    [self logNativeAdViewInfoAfterShow];
}

- (void)nativeAdExpressView:(ABUNativeAdView *_Nonnull)nativeAdView stateDidChanged:(ABUPlayerPlayState)playerState {
    
}

/// 广告点击回调
- (void)nativeAdDidClick:(ABUNativeAdView *_Nonnull)nativeAdView withView:(UIView *_Nullable)view {
    
}

- (void)nativeAdViewWillPresentFullScreenModal:(ABUNativeAdView *_Nonnull)nativeAdView {
    
}

/// 广告关闭回调
- (void)nativeAdExpressViewDidClosed:(ABUNativeAdView *_Nullable)nativeAdView closeReason:(NSArray<NSDictionary *> *_Nullable)filterWords {
    // 可于此处移除广告view
}

- (void)nativeAdShakeViewDidDismiss:(ABUNativeAdView *)nativeAdView {
    // shake view 消失
    NSLog(@"3.9.0.0 baidu 接收 shake view dismiss 回调");
}

- (void)nativeAdViewDidDismissFullScreenModal:(ABUNativeAdView *)nativeAdView {
    // 广告落地页关闭回调
}

- (void)nativeAdVideo:(ABUNativeAdView *)nativeAdView stateDidChanged:(ABUPlayerPlayState)playerState {
    
}

- (void)nativeAdVideo:(ABUNativeAdView *)nativeAdView rewardDidCountDown:(NSInteger)countDown {
    
}

- (void)nativeAdVideoDidClick:(ABUNativeAdView *)nativeAdView {
    
}

- (void)nativeAdVideoDidPlayFinish:(ABUNativeAdView *)nativeAdView {
    
}
#pragma mark ----- 可忽略 -----

- (ABUNativeAdView *)nativeAdView {
    return objc_getAssociatedObject(self, @selector(nativeAdView));
}

- (void)setNativeAdView:(ABUNativeAdView *)nativeAdView {
    objc_setAssociatedObject(self, @selector(nativeAdView), nativeAdView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetNativeAd {
    self.nativeAd.delegate = nil;
    self.nativeAd = nil;
}

- (void)logNativeAdViewInfoAfterShow {
    // 展示后可获取信息如下
    ABUD_Log(@"%@", [self.nativeAdView getShowEcpmInfo]);
}
@end
