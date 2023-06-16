//
//  ABUDCustomRewardedVideoAdapter.m
//  ABUDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "ABUDCustomRewardedVideoAdapter.h"
#import "ABUDCustomRewardedVideoView.h"
#import "ABUDStoreViewController.h"

@interface ABUDCustomRewardedVideoAdapter ()
@property (nonatomic, strong) ABUDCustomRewardedVideoView *view;

@property (nonatomic, weak) UIViewController *viewController;
@end

@implementation ABUDCustomRewardedVideoAdapter

- (ABUMediatedAdStatus)mediatedAdStatus {
    return ABUMediatedAdStatusNormal;
}

- (void)loadRewardedVideoAdWithSlotID:(nonnull NSString *)slotID andParameter:(nonnull NSDictionary *)parameter {
    ABUBiddingType biddingType = [parameter[ABUAdLoadingParamBiddingType] integerValue];
    __weak typeof(self) ws = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(ws) self = ws;
        NSMutableDictionary *ext = [NSMutableDictionary dictionary];
        switch (biddingType) {
            case ABUBiddingTypeClient:
                [ext setValue:@"100" forKey:ABUMediaAdLoadingExtECPM];
                break;
            case ABUBiddingTypeMulti:
                [ext setValue:@"100" forKey:ABUMediaAdLoadingExtECPMLevel];
            default:
                break;
        }
        // 模拟加载广告成功
        [self.bridge rewardedVideoAd:self didLoadWithExt:ext.copy];
        
        // 模拟广告视频资源加载成功，可选
        [self.bridge rewardedVideoAdVideoDidLoad:self];
    });
}

- (BOOL)showAdFromRootViewController:(UIViewController * _Nonnull)viewController parameter:(nonnull NSDictionary *)parameter {
    self.viewController = viewController;
    self.view = [ABUDCustomRewardedVideoView fullscreenView];
    [self.view showInViewController:viewController];
    __weak typeof(self) ws = self;
    // 模拟广告关闭
    self.view.dismissCallback = ^(ABUDCustomRewardedVideoView * _Nonnull view, BOOL skip) {
        __strong typeof(ws) self = ws;
        if (!skip) {
            // 模拟广告获取奖励
            [self.bridge rewardedVideoAd:self didServerRewardSuccessWithInfo:^(ABUAdapterRewardAdInfo * _Nonnull info) {
                info.rewardName = @"[可选]";
                info.rewardAmount = 1;
                info.tradeId = @"[可选]";
                info.verify = YES;
            }];
        }
        [self.bridge rewardedVideoAdDidClose:self];
    };
    // 模拟点击跳过
    self.view.skipCallback = ^(ABUDCustomRewardedVideoView * _Nonnull view) {
        __strong typeof(ws) self = ws;
        [self.bridge rewardedVideoAdDidClickSkip:self];
    };
    // 模拟广告点击事件
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)]];
    // 模拟广告展示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bridge rewardedVideoAdDidVisible:self];
    });
    // 模拟广告播放完成
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bridge rewardedVideoAd:self didPlayFinishWithError:nil];
    });
    return YES;
}

- (void)didReceiveBidResult:(ABUMediaBidResult *)result {
    // 在此处理Client Bidding的结果回调
}

- (void)didClick {
    [self.bridge rewardedVideoAdDidClick:self];
    [self.bridge rewardedVideoAdWillPresentFullScreenModel:self];
    ABUDStoreViewController *vc = [[ABUDStoreViewController alloc] init];
    [vc openAppStoreWithAppId:@"1142110895" fromViewController:self.viewController complete:^{
        [self.bridge rewardedVideoAdWillDismissFullScreenModel:self];
    }];
}

@end
