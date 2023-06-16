//
//  ABUDCustomFullscreenVideoAdapter.m
//  ABUDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "ABUDCustomFullscreenVideoAdapter.h"
#import "ABUDCustomFullscreenView.h"
#import "ABUDStoreViewController.h"

@interface ABUDCustomFullscreenVideoAdapter ()

@property (nonatomic, strong) ABUDCustomFullscreenView *view;

@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation ABUDCustomFullscreenVideoAdapter

- (ABUMediatedAdStatus)mediatedAdStatus {
    return ABUMediatedAdStatusNormal;
}

- (void)loadFullscreenVideoAdWithSlotID:(nonnull NSString *)slotID andParameter:(nonnull NSDictionary *)parameter {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 模拟广告加载成功回调
        [self.bridge fullscreenVideoAd:self didLoadWithExt:@{}];
        // 模拟广告视频加载完成回调
        [self.bridge fullscreenVideoAdVideoDidLoad:self];
    });
}

- (BOOL)showAdFromRootViewController:(UIViewController * _Nonnull)viewController parameter:(nonnull NSDictionary *)parameter {
    self.viewController = viewController;
    self.view = [ABUDCustomFullscreenView fullscreenView];
    [self.view showInViewController:viewController];
    __weak typeof(self) ws = self;
    // 模拟广告关闭事件
    self.view.dismissCallback = ^(ABUDCustomFullscreenView * _Nonnull view) {
        __strong typeof(ws) self = ws;
        [self.bridge fullscreenVideoAdDidClose:self];
    };
    // 模拟广告点击跳过事件
    self.view.skipCallback = ^(ABUDCustomFullscreenView * _Nonnull view) {
        __strong typeof(ws) self = ws;
        [self.bridge fullscreenVideoAdDidClickSkip:self];
    };
    // 模拟广告点击事件
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bridge fullscreenVideoAdDidVisible:self];
    });
    // 模拟广告视频播放完成事件
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bridge fullscreenVideoAd:self didPlayFinishWithError:nil];
    });
    return YES;
}

- (void)didReceiveBidResult:(ABUMediaBidResult *)result {
    // 在此处理Client Bidding的结果回调
}

- (void)didClick {
    [self.bridge fullscreenVideoAdDidClick:self];
    [self.bridge fullscreenVideoAdWillPresentFullscreenModal:self];
    ABUDStoreViewController *vc = [[ABUDStoreViewController alloc] init];
    [vc openAppStoreWithAppId:@"1142110895" fromViewController:self.viewController complete:^{}];
}

@end
