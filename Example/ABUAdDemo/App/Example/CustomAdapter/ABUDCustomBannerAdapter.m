//
//  ABUDCustomBannerAdapter.m
//  ABUDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "ABUDCustomBannerAdapter.h"
#import "ABUDStoreViewController.h"
#import "ABUDCustomBannerView.h"

#import "ABUDCustomExpressNativeView.h"
#import "ABUDCustomNativeAdHelper.h"
#import "ABUDCustomNativeData.h"
#import "ABUDCustomNativeAdHelper.h"
#import "ABUDCustomNativeView.h"

@interface ABUDCustomBannerAdapter ()

// common
@property (nonatomic, assign) NSInteger adSubType;// 混用代码位时，代码位类型
@property (nonatomic, assign) NSTimeInterval lastLoadTimeInterval;
// banner -> adSubType == 3
@property (nonatomic, strong) ABUDCustomBannerView *bannerView;
// mix native -> adSubType == 4
@property (nonatomic, strong) ABUDCustomExpressNativeView *expressNativeView;
@property (nonatomic, strong) ABUCanvasView *canvasView;
@property (nonatomic, strong) ABUDCustomNativeData *customNativeData;

@end

@implementation ABUDCustomBannerAdapter

- (ABUMediatedAdStatus)mediatedAdStatus {
    ABUMediatedAdStatus status = ABUMediatedAdStatusNormal;
    if (self.lastLoadTimeInterval + 30.f > CACurrentMediaTime()) { // 模拟30秒，广告过期
        status.unexpired = ABUMediatedAdStatusValueDeny;
    }
    return status;
}

- (void)loadBannerAdWithSlotID:(nonnull NSString *)slotID andSize:(CGSize)adSize parameter:(nullable NSDictionary *)parameter {
    // 混用代码位时，代码位类型
    self.adSubType = [parameter[ABUAdLoadingParamAdSubType] integerValue];
    if (self.adSubType == 4) { // banner广告位下混用信息流代码位
        [self _mixNativeloadNativeAdWithSlotID:slotID andSize:adSize imageSize:[parameter[ABUAdLoadingParamNAExpectImageSize] CGSizeValue] parameter:parameter];
    } else { // banner代码位
        if (CGSizeEqualToSize(adSize, CGSizeZero)) adSize = CGSizeMake(300, 200);
        // 模拟加载耗时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CGRect frame = (CGRect){CGPointZero, adSize};
            ABUDCustomBannerView *bannerView = [[ABUDCustomBannerView alloc] initWithFrame:frame];
            self.bannerView = bannerView;
            __weak typeof(self) ws = self;
            // 模拟展示回调
            bannerView.didMoveToSuperViewCallback = ^(ABUDCustomBannerView *view) {
                __strong typeof(ws) self = ws;
                [self.bridge bannerAdDidBecomeVisible:self bannerView:view];
            };
            // 模拟关闭回调
            bannerView.closeAction = ^(ABUDCustomBannerView *view) {
                __strong typeof(ws) self = ws;
                [self.bridge bannerAd:self bannerView:view didClosedWithDislikeWithReason:@[]];
            };
            // 模拟点击回调
            [bannerView addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
            // 模拟加载成功回调
            [self.bridge bannerAd:self didLoad:bannerView ext:@{
                // 模拟回调补充参数
                ABUMediaAdLoadingExtECPM : @"[可选]更多字段参考ABUAdLoadingParams.h"
            }];
            self.lastLoadTimeInterval = CACurrentMediaTime();
        });
    }

}

- (void)_mixNativeloadNativeAdWithSlotID:(nonnull NSString *)slotID andSize:(CGSize)size imageSize:(CGSize)imageSize parameter:(nonnull NSDictionary *)parameter {
    // 获取是否需要加载模板广告，非必要，视network支持而定
    NSInteger renderType = [parameter[ABUAdLoadingParamExpressAdType] integerValue];
    // 模拟广告加载耗时，开发者需在此调用network加载广告方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (renderType == 1) { // 此处仅说明渲染类型可下发，开发者需根据实际定义情况编写
            // 模拟加载模板广告
            ABUDCustomExpressNativeView *view = [[ABUDCustomExpressNativeView alloc] initWithSize:size andImageSize:imageSize];
            self.expressNativeView = view;
            __weak typeof(self) ws = self;
            // 模拟广告点击事件
            view.didClickAction = ^(ABUDCustomExpressNativeView * _Nonnull view) {
                __strong typeof(ws) self = ws;
                [self.bridge bannerAdDidClick:self bannerView:view];
                [self.bridge bannerAdWillPresentFullScreenModal:self bannerView:view];
            };
            // 模拟广告展示事件
            view.didMoveToSuperViewCallback = ^(ABUDCustomExpressNativeView * _Nonnull view) {
                __strong typeof(ws) self = ws;
                [self.bridge bannerAdDidBecomeVisible:self bannerView:view];
            };
            // 模拟广告关闭事件
            view.didClickCloseAction = ^(ABUDCustomExpressNativeView * _Nonnull view) {
                __strong typeof(ws) self = ws;
                [self.bridge bannerAd:self bannerView:view didClosedWithDislikeWithReason:@[]];
            };
            view.viewController = self.bridge.viewControllerForPresentingModalView;
            NSDictionary *ext = @{
                ABUMediaAdLoadingExtECPM : @"1000",
            };
            view.viewController = self.bridge.viewControllerForPresentingModalView;
            
            [self.bridge bannerAd:self didLoad:view ext:ext];
        } else {
            // 模拟加载非模板广告
            ABUDCustomNativeData *data = [ABUDCustomNativeData randomDataWithImageSize:imageSize];
            self.customNativeData = data;
            __weak typeof(self) ws = self;
            // 模拟广告点击事件
            data.didClickAction = ^(ABUDCustomNativeData * _Nonnull data) {
                __strong typeof(ws) self = ws;
                [self.bridge bannerAdDidClick:self bannerView:self.canvasView];
                [self.bridge bannerAdWillPresentFullScreenModal:self bannerView:self.canvasView];
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
                    [self.bridge bannerAdDidBecomeVisible:self bannerView:self.canvasView];
                }; v;
            });
            ad.viewCreator = helper;
            ad.data = helper;
            NSDictionary *ext = @{
                ABUMediaAdLoadingExtECPM : @"1000",
            };
            
            ABUCanvasView *view = [[ABUCanvasView alloc]initWithNativeAd:ad adapter:self];
            self.canvasView = view;
            
            [self.bridge bannerAd:self didLoad:self.canvasView ext:ext];
        }
    });
}

- (void)registerContainerView:(nonnull __kindof UIView *)containerView andClickableViews:(nonnull NSArray<__kindof UIView *> *)views forNativeAd:(nonnull id)nativeAd {
    if ([nativeAd isKindOfClass:[ABUDCustomNativeData class]]) {
        ABUDCustomNativeData *ad = (ABUDCustomNativeData *)nativeAd;
        [ad registerClickableViews:views];
    }
}

- (void)didReceiveBidResult:(ABUMediaBidResult *)result {
    // 在此处理Client Bidding的结果回调
}

- (void)didClick:(ABUDCustomBannerView *)sender {
    [self.bridge bannerAdDidClick:self bannerView:sender];
    [self.bridge bannerAdWillPresentFullScreenModal:self bannerView:sender];
    ABUDStoreViewController *vc = [[ABUDStoreViewController alloc] init];
    [vc openAppStoreWithAppId:@"1142110895" fromViewController:self.bridge.viewControllerForPresentingModalView complete:^{
        [self.bridge bannerAdWillDismissFullScreenModal:self bannerView:sender];
    }];
}

@end
