//
//  ABUDCustomNativeAdapter.m
//  ABUDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "ABUDCustomNativeAdapter.h"
#import "ABUDCustomExpressNativeView.h"
#import "ABUDCustomNativeAdHelper.h"
#import "ABUDCustomNativeData.h"
#import "ABUDCustomNativeView.h"

@implementation ABUDCustomNativeAdapter

/// 当前加载的广告的状态，native模板广告
- (ABUMediatedAdStatus)mediatedAdStatusWithExpressView:(UIView *)view {
    return ABUMediatedAdStatusUnknown;
}

/// 当前加载的广告的状态，native非模板广告
- (ABUMediatedAdStatus)mediatedAdStatusWithMediatedNativeAd:(ABUMediatedNativeAd *)ad {
    return ABUMediatedAdStatusUnknown;
}

- (void)loadNativeAdWithSlotID:(nonnull NSString *)slotID andSize:(CGSize)size imageSize:(CGSize)imageSize parameter:(nonnull NSDictionary *)parameter {
    // 获取广告加载数量
    NSInteger count = [parameter[ABUAdLoadingParamNALoadAdCount] integerValue];
    // 获取是否需要加载模板广告，非必要，视network支持而定
    NSInteger renderType = [parameter[ABUAdLoadingParamExpressAdType] integerValue];
    // 模拟广告加载耗时，开发者需在此调用network加载广告方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (renderType == 1) { // 此处仅说明渲染类型可下发，开发者需根据实际定义情况编写
            // 模拟加载模板广告
            NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
            NSMutableArray *exts = [NSMutableArray arrayWithCapacity:count];
            for (int i = 0; i < count; i++) {
                ABUDCustomExpressNativeView *view = [[ABUDCustomExpressNativeView alloc] initWithSize:size andImageSize:imageSize];
                __weak typeof(self) ws = self;
                // 模拟广告点击事件
                view.didClickAction = ^(ABUDCustomExpressNativeView * _Nonnull view) {
                    __strong typeof(ws) self = ws;
                    [self.bridge nativeAd:self didClickWithMediatedNativeAd:view];
                    [self.bridge nativeAd:self willPresentFullScreenModalWithMediatedNativeAd:view];
                };
                // 模拟广告展示事件
                view.didMoveToSuperViewCallback = ^(ABUDCustomExpressNativeView * _Nonnull view) {
                    __strong typeof(ws) self = ws;
                    [self.bridge nativeAd:self didVisibleWithMediatedNativeAd:view];
                };
                // 模拟广告关闭事件
                view.didClickCloseAction = ^(ABUDCustomExpressNativeView * _Nonnull view) {
                    __strong typeof(ws) self = ws;
                    [self.bridge nativeAd:self didCloseWithExpressView:view closeReasons:@[]];
                };
                view.viewController = self.bridge.viewControllerForPresentingModalView;
                [list addObject:view];
                [exts addObject:@{
                    ABUMediaAdLoadingExtECPM : @"1000",
                }];
            }
            [self.bridge nativeAd:self didLoadWithExpressViews:[list copy] exts:exts.copy];
        } else {
            // 模拟加载非模板广告
            NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
            NSMutableArray *exts = [NSMutableArray arrayWithCapacity:count];
            for (int i = 0; i < count; i++) {
                ABUDCustomNativeData *data = [ABUDCustomNativeData randomDataWithImageSize:imageSize];
                __weak typeof(self) ws = self;
                // 模拟广告点击事件
                data.didClickAction = ^(ABUDCustomNativeData * _Nonnull data) {
                    __strong typeof(ws) self = ws;
                    [self.bridge nativeAd:self didClickWithMediatedNativeAd:data];
                    [self.bridge nativeAd:self willPresentFullScreenModalWithMediatedNativeAd:data];
                };
                data.viewController = self.bridge.viewControllerForPresentingModalView;
                id<ABUMediatedNativeAdData, ABUMediatedNativeAdViewCreator> helper = [[ABUDCustomNativeAdHelper alloc] initWithAdData:data];
                // 构造需要返回GroMore的非模板广告数据
                ABUMediatedNativeAd *ad = [[ABUMediatedNativeAd alloc] init];
                ad.originMediatedNativeAd = data;
                ad.view = ({
                    ABUDCustomNativeView *v = [[ABUDCustomNativeView alloc] init];
                    v.didMoveToSuperViewCallback = ^(ABUDCustomNativeView * _Nonnull view) {
                        __strong typeof(ws) self = ws;
                        [self.bridge nativeAd:self didVisibleWithMediatedNativeAd:data]; // 注意：使用原始广告数据
                    }; v;
                });
                ad.viewCreator = helper;
                ad.data = helper;
                [list addObject:ad];
                [exts addObject:@{
                    ABUMediaAdLoadingExtECPM : @"1000",
                }];
            }
            [self.bridge nativeAd:self didLoadWithNativeAds:[list copy] exts:exts.copy];
        }
    });
}

- (void)registerContainerView:(nonnull __kindof UIView *)containerView andClickableViews:(nonnull NSArray<__kindof UIView *> *)views forNativeAd:(nonnull id)nativeAd {
    if ([nativeAd isKindOfClass:[ABUDCustomNativeData class]]) {
        ABUDCustomNativeData *ad = (ABUDCustomNativeData *)nativeAd;
        [ad registerClickableViews:views];
    }
}

- (void)renderForExpressAdView:(nonnull UIView *)expressAdView {
    // 如不adn广告不需要render，请尽量模拟回调renderSuccess
    [self.bridge nativeAd:self renderSuccessWithExpressView:expressAdView];
}

- (void)setRootViewController:(nonnull UIViewController *)viewController forExpressAdView:(nonnull UIView *)expressAdView {
    if ([expressAdView isKindOfClass:[ABUDCustomExpressNativeView class]]) {
        ABUDCustomExpressNativeView *view = (ABUDCustomExpressNativeView *)expressAdView;
        view.viewController = viewController;
    }
}

- (void)setRootViewController:(nonnull UIViewController *)viewController forNativeAd:(nonnull id)nativeAd {
    if ([nativeAd isKindOfClass:[ABUDCustomNativeData class]]) {
        ABUDCustomNativeData *ad = (ABUDCustomNativeData *)nativeAd;
        ad.viewController = viewController;
    }
}

- (void)didReceiveBidResult:(ABUMediaBidResult *)result {
    // 在此处理Client Bidding的结果回调
}

@end
