//
//  ABUDCustomDrawAdapter.m
//  ABUDemo
//
//  Created by ByteDance on 2022/5/5.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "ABUDCustomDrawAdapter.h"
#import "ABUDCustomExpressDrawView.h"
#import "ABUDCustomDrawAdHelper.h"
#import "ABUDCustomDrawData.h"
#import "ABUDCustomDrawView.h"

@implementation ABUDCustomDrawAdapter

/// 当前加载的广告的状态，native模板广告
- (ABUMediatedAdStatus)mediatedAdStatusWithExpressView:(UIView *)view {
    return ABUMediatedAdStatusUnknown;
}

/// 当前加载的广告的状态，native非模板广告
- (ABUMediatedAdStatus)mediatedAdStatusWithMediatedNativeAd:(ABUMediatedNativeAd *)ad {
    return ABUMediatedAdStatusUnknown;
}

- (void)loadDrawAdWithSlotID:(nonnull NSString *)slotID andSize:(CGSize)size andParameter:(nonnull NSDictionary *)parameter {
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
                ABUDCustomExpressDrawView *view = [[ABUDCustomExpressDrawView alloc] initWithSize:size];
                __weak typeof(self) ws = self;
                // 模拟广告点击事件
                view.didClickAction = ^(ABUDCustomExpressDrawView * _Nonnull view) {
                    __strong typeof(ws) self = ws;
                    [self.bridge drawAd:self videoDidClick:view];
                    [self.bridge drawAd:self willPresentFullScreenModalWithMediatedAd:view];
                };
                // 模拟广告展示事件
                view.didMoveToSuperViewCallback = ^(ABUDCustomExpressDrawView * _Nonnull view) {
                    __strong typeof(ws) self = ws;
                    [self.bridge drawAd:self didVisibleWithMediatedAd:view];
                };
                // 模拟广告关闭事件
                view.didClickCloseAction = ^(ABUDCustomExpressDrawView * _Nonnull view) {
                    __strong typeof(ws) self = ws;
                    [self.bridge drawAd:self didCloseWithExpressView:view closeReasons:@[]];
                };
                view.viewController = self.bridge.viewControllerForPresentingModalView;
                [list addObject:view];
                [exts addObject:@{
                    ABUMediaAdLoadingExtECPM : @"1000",
                }];
            }
            [self.bridge drawAd:self didLoadWithDrawAds:[list copy] exts:[exts copy]];
        } else {
            // 模拟加载非模板广告
            NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
            NSMutableArray *exts = [NSMutableArray arrayWithCapacity:count];
            for (int i = 0; i < count; i++) {
                ABUDCustomDrawData *data = [ABUDCustomDrawData randomData];
                __weak typeof(self) ws = self;
                // 模拟广告点击事件
                data.didClickAction = ^(ABUDCustomDrawData * _Nonnull data) {
                    __strong typeof(ws) self = ws;
                    [self.bridge drawAd:self videoDidClick:data];
                    [self.bridge drawAd:self willPresentFullScreenModalWithMediatedAd:data];
                };
                data.viewController = self.bridge.viewControllerForPresentingModalView;
                id<ABUMediatedNativeAdData, ABUMediatedNativeAdViewCreator> helper = [[ABUDCustomDrawAdHelper alloc] initWithAdData:data];
                // 构造需要返回GroMore的非模板广告数据
                ABUMediatedNativeAd *ad = [[ABUMediatedNativeAd alloc] init];
                ad.originMediatedNativeAd = data;
                ad.view = ({
                    ABUDCustomDrawView *v = [[ABUDCustomDrawView alloc] init];
                    v.didMoveToSuperViewCallback = ^(ABUDCustomDrawView * _Nonnull view) {
                        __strong typeof(ws) self = ws;
                        [self.bridge drawAd:self didVisibleWithMediatedAd:data]; // 注意：使用原始广告数据
                    }; v;
                });
                ad.viewCreator = helper;
                ad.data = helper;
                [list addObject:ad];
                [exts addObject:@{
                    ABUMediaAdLoadingExtECPM : @"1000",
                }];
            }
            [self.bridge drawAd:self didLoadWithDrawAds:[list copy] exts:[exts copy]];
        }
    });
}

/// 为模板广告设置控制器
/// @param viewController 控制器
/// @param expressAdView 模板广告
- (void)setRootViewController:(UIViewController *)viewController forExpressAdView:(UIView *)expressAdView {
    if ([expressAdView isKindOfClass:[ABUDCustomExpressDrawView class]]) {
        ABUDCustomExpressDrawView *view = (ABUDCustomExpressDrawView *)expressAdView;
        view.viewController = viewController;
    }
}

/// 为非模板广告设置控制器
/// @param viewController 控制器
/// @param drawAd 非模板广告
- (void)setRootViewController:(UIViewController *)viewController forDrawAd:(id)drawAd {
    if ([drawAd isKindOfClass:[ABUDCustomDrawData class]]) {
        ABUDCustomDrawData *ad = (ABUDCustomDrawData *)drawAd;
        ad.viewController = viewController;
    }
}

- (void)didReceiveBidResult:(ABUMediaBidResult *)result {
    
}

@end
