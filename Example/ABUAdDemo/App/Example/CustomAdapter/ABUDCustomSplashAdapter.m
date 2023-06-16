//
//  ABUDCustomSplashAdapter.m
//  ABUDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "ABUDCustomSplashAdapter.h"
#import "ABUDCustomSplashView.h"

@interface ABUDCustomSplashAdapter ()

@property (nonatomic, strong) ABUDCustomSplashView *splashView;

@property (nonatomic, strong) UIView *customBottomView;

@end

@implementation ABUDCustomSplashAdapter

- (ABUMediatedAdStatus)mediatedAdStatus {
    return ABUMediatedAdStatusNormal;
}

- (void)dismissSplashAd {
    [self.splashView removeFromSuperview];
    [self.customBottomView removeFromSuperview];
}

- (void)loadSplashAdWithSlotID:(nonnull NSString *)slotID andParameter:(nonnull NSDictionary *)parameter {
    CGSize size = [parameter[ABUAdLoadingParamSPExpectSize] CGSizeValue];
    self.customBottomView = parameter[ABUAdLoadingParamSPCustomBottomView];
    
    self.splashView = [ABUDCustomSplashView splashViewWithSize:size rootViewController:self.bridge.viewControllerForPresentingModalView];
    __weak typeof(self) ws = self;
    // 模拟点击事件
    self.splashView.didClickAction = ^(ABUDCustomSplashView * _Nonnull view) {
        __strong typeof(ws) self = ws;
        [self.bridge splashAdDidClick:self];
    };
    // 模拟关闭事件
    self.splashView.dismissCallback = ^(ABUDCustomSplashView * _Nonnull view, BOOL skip) {
        __strong typeof(ws) self = ws;
        if (skip) {
            [self.bridge splashAdDidClickSkip:self];
        } else {
            [self.bridge splashAdDidCountDownToZero:self];
        }
        [self.bridge splashAdDidClose:self];
    };
    // 模拟加载完成
    [self.bridge splashAd:self didLoadWithExt:@{}];
}

- (void)showSplashAdInWindow:(nonnull UIWindow *)window parameter:(nonnull NSDictionary *)parameter {
    [self.splashView showInWindow:window];
    if (self.customBottomView) {
        [window addSubview:self.customBottomView];
    }
    // 模拟广告展示回调
    [self.bridge splashAdWillVisible:self];
}


- (void)didReceiveBidResult:(ABUMediaBidResult *)result {
    // 在此处理Client Bidding的结果回调
}
@end
