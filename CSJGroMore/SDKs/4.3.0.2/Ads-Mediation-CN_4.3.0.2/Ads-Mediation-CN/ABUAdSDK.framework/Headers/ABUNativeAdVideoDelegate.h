//
// Created by bytedance on 2021/7/8.
// Copyright (c) 2021 wangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABUPlayerPlayState.h"

@class ABUNativeAdView;

@protocol ABUNativeAdVideoDelegate <NSObject>

@optional

/// 当视频播放状态改变之后触发
/// @param nativeAdView 广告视图
/// @param playerState 变更后的播放状态
- (void)nativeAdVideo:(ABUNativeAdView *_Nullable)nativeAdView stateDidChanged:(ABUPlayerPlayState)playerState;

/// 激励信息流视频进入倒计时状态时调用
/// @param nativeAdView 广告视图
/// @param countDown : 倒计时
/// @Note : 当前该回调仅适用于CSJ广告 - v4200
- (void)nativeAdVideo:(ABUNativeAdView *_Nullable)nativeAdView rewardDidCountDown:(NSInteger)countDown;

/// 广告视图中视频视图被点击时触发
/// @param nativeAdView 广告视图
- (void)nativeAdVideoDidClick:(ABUNativeAdView *_Nullable)nativeAdView;


/// 广告视图中视频播放完成时触发
/// @param nativeAdView 广告视图
- (void)nativeAdVideoDidPlayFinish:(ABUNativeAdView *_Nullable)nativeAdView;

@end
