//
//  GromoreDemoController+DrawAd.m
//  ABUDemo
//
//  Created by heyinyin on 2022/4/21.
//  Copyright © 2022 bytedance. All rights reserved.
//
// Draw广告加载Demo

#import "GromoreDemoController+DrawAd.h"
#import "GromoreDemoController+Ad.h"
#import <objc/runtime.h>
#import "ABUDMacros.h"

/// Gromore
#import "ABUDrawAdView+CustomRender.h"

@interface GromoreDemoController ()
<ABUDrawAdsManagerDelegate, ABUDrawAdViewDelegate, ABUDrawAdVideoDelegate>

@property (nonatomic, strong) UIView *backView;

@end

@implementation GromoreDemoController (DrawAd)

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadDrawAdWithConfig:(GromoreAdLoadConfig *)config andParam:(GromoreAdLoadParam *)param {
    // 初始化广告加载对象
    self.drawAd = [[ABUDrawAdsManager alloc] initWithAdUnitID:config.slotID adSize:config.adSize];
    // 配置：跳转控制器
    self.drawAd.rootViewController = self;
    // 配置：回调代理对象
    self.drawAd.delegate = self;
    // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUDrawAdsManager.h`文件
    
    // 开始加载广告
    [self.drawAd loadAdDataWithCount:1];
}

// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
- (void)showDrawAd {
    if (!self.drawAdView) return;
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat x = (size.width - size.width * 0.7) / 2;
    CGFloat y = (size.height - size.height * 0.7 ) / 2;
    
    // 广告view操作逻辑
    self.drawAdView.frame = (CGRect){CGPointMake(x, y), CGSizeMake(size.width * 0.7,size.height * 0.7)};
    if (self.drawAdView.isExpressAd) {
        // 模板广告：使用ADN的渲染方法进行渲染
        [self.drawAdView render];
    } else {
        // 自渲染广告：开发者需自行渲染
        [self.drawAdView customRender];
    }
    
    // 无需关注
    [self dispalyAdViewWithSize:size];

}

- (void)closeAdView {
    [self.backView removeFromSuperview];
}

#pragma mark ----- ABUDrawAdsManagerDelegate -----
- (void)drawAdsManagerSuccessToLoad:(ABUDrawAdsManager *)adsManager drawVideoAds:(NSArray<ABUDrawAdView *> *)drawAds {
    // view取值,⚠️ 请慎重
    self.drawAdView = drawAds.firstObject;
    
    // 重点:务必设定后续回调代理
    self.drawAdView.delegate = self;
    self.drawAdView.videoDelegate = self;
}

- (void)drawAdsManager:(ABUDrawAdsManager *)adsManager didFailWithError:(NSError *)error {
    
}

#pragma mark ----- ABUDrawAdViewDelegate -----
- (void)drawAdExpressViewRenderSuccess:(ABUDrawAdView *_Nonnull)drawAdView {
    
}

- (void)drawAdExpressViewRenderFail:(ABUDrawAdView *_Nonnull)drawAdView error:(NSError *_Nullable)error {
    
}

- (void)drawAdExpressViewDidClosed:(ABUDrawAdView *_Nullable)drawAdView closeReason:(NSArray<NSDictionary *> *_Nullable)filterWords {
    
}

- (void)drawAdDidClosed:(ABUDrawAdView *_Nullable)drawAdView closeReason:(NSArray<NSDictionary *> *_Nullable)filterWords {
    
}

- (void)drawAdDidBecomeVisible:(ABUDrawAdView *_Nonnull)drawAdView {
    [self logDrawAdViewInfoAfterShow];
}

- (void)drawAdView:(ABUDrawAdView *_Nonnull)drawAdView stateDidChanged:(ABUPlayerPlayState)playerState {
    
}

- (void)drawAdDidClick:(ABUDrawAdView *_Nonnull)drawAdView withView:(UIView *_Nullable)view {
    
}

- (void)drawAdViewWillPresentFullScreenModal:(ABUDrawAdView *_Nonnull)drawAdView {
    
}

- (void)drawAdViewWillDismissFullScreenModal:(ABUDrawAdView *_Nonnull)drawAdView {
    
}

#pragma mark ----- ABUDrawAdVideoDelegate -----
- (void)drawAdVideo:(ABUDrawAdView *_Nullable)drawAdView stateDidChanged:(ABUPlayerPlayState)playerState {
    
}

- (void)drawAdVideoDidClick:(ABUDrawAdView *_Nullable)drawAdView {
    
}

- (void)drawAdVideoDidPlayFinish:(ABUDrawAdView *_Nullable)drawAdView {
    
}
#pragma mark ----- 可忽略 -----

- (void)dispalyAdViewWithSize:(CGSize)size {
    // 移除广告相关操作所使用的view
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.backView addSubview:self.drawAdView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.drawAdView.frame) + 10, CGRectGetMinY(self.drawAdView.frame) - 50, 25, 25)];
    [button setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeAdView) forControlEvents:UIControlEventTouchUpInside];
    // 添加view
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.backView];
    [self.backView addSubview:button];
}

- (UIView *)backView {
    return objc_getAssociatedObject(self, @selector(backView));
}

- (void)setBackView:(UIView *)backView {
    objc_setAssociatedObject(self, @selector(backView), backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ABUDrawAdView *)drawAdView {
    return objc_getAssociatedObject(self, @selector(drawAdView));
}

- (void)setDrawAdView:(ABUDrawAdView *)drawAdView {
    objc_setAssociatedObject(self, @selector(drawAdView), drawAdView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetDrawAd {
    self.drawAd.delegate = nil;
    self.drawAd = nil;
}

- (void)logDrawAdViewInfoAfterShow {
    // 展示后可获取信息如下
    ABUD_Log(@"%@", [self.drawAdView getShowEcpmInfo]);
}
@end
