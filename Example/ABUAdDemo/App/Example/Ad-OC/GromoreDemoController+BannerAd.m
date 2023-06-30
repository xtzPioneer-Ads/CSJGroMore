//
//  GromoreDemoController+BannerAd.m
//  ABUDemo
//
//  Created by bytedance on 2022/2/10.
//  Copyright © 2022 bytedance. All rights reserved.
//
// Banner广告加载Demo

/// Demo
#import "GromoreDemoController+BannerAd.h"
#import "GromoreDemoController+Ad.h"
#import <objc/runtime.h>
#import "ABUDMacros.h"
#import "ABUNativeAdView+CustomRender.h"

/// Gromore
#import "GroMore.h"

@interface GromoreDemoController () <ABUBannerAdDelegate>

@property (nonatomic, strong) UIView *bannerView;

@end

@implementation GromoreDemoController (BannerAd)

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadBannerAdWithConfig:(GromoreAdLoadConfig *)config andParam:(GromoreAdLoadParam *)param {
    
    // 初始化广告加载对象
    self.bannerAd = [[ABUBannerAd alloc] initWithAdUnitID:config.slotID rootViewController:self adSize:config.adSize];
    // 配置：回调代理对象
    self.bannerAd.delegate = self;
    // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUBannerAd.h`文件
    // [可选]混用信息流时可选配置：静音
    self.bannerAd.startMutedIfCan = YES;
    // 轮播相关配置需要在平台配置
    
    // 开始加载广告
    [self.bannerAd loadAdData];
}

// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
- (void)showBannerAd {
    [self showAdView:^UIView *(CGSize size) {
        return self.bannerView;
    }];
}

#pragma mark ----- ABUBannerAdDelegate -----
/// 加载成功回调
- (void)bannerAdDidLoad:(ABUBannerAd *)bannerAd bannerView:(UIView *)bannerView {
    
    self.bannerView = bannerView;
}

/// 加载失败回调
- (void)bannerAd:(ABUBannerAd *)bannerAd didLoadFailWithError:(NSError *)error {
    
}

/// 展示成功回调
- (void)bannerAdDidBecomeVisible:(ABUBannerAd *)bannerAd bannerView:(UIView *)bannerView {
    
    // 加载后打印ad信息
    [self logBannerAdInfoAfterShow];
}

/// 广告点击回调
- (void)bannerAdDidClick:(ABUBannerAd *)ABUBannerAd bannerView:(UIView *)bannerView {
    
}

/// 广告关闭回调
- (void)bannerAdDidClosed:(ABUBannerAd *)ABUBannerAd bannerView:(UIView *)bannerView dislikeWithReason:(NSArray<NSDictionary *> *)filterwords {
    // 可于此处移除广告view
}

/// 混用信息流自渲染广告时会回调该方法，开发者需要在该回调中布局自渲染视图
- (void)bannerAdNeedLayoutUI:(ABUBannerAd *)bannerAd canvasView:(ABUCanvasView *)canvasView {
    // 在此按实际需要布局UI，可参考Demo中`-[ABUNativeAdView customRender]`
}

#pragma mark ----- 可忽略 -----
/// property
- (UIView *)bannerView {
    return objc_getAssociatedObject(self, @selector(bannerView));
}

- (void)setBannerView:(UIView *)bannerView {
    objc_setAssociatedObject(self, @selector(bannerView), bannerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetBannerAd {
    self.bannerAd.delegate = nil;
    self.bannerAd = nil;
}

- (void)logBannerAdInfoAfterShow {
    // 展示后可获取信息如下
    ABUD_Log(@"%@", [self.bannerAd getShowEcpmInfo]);
}

@end
