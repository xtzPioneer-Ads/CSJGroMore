//
//  ABUNativeAdView+CustomRender.h
//  ABUDemo
//
//  Created by bytedance on 2022/2/11.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "GroMore.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABUNativeAdView (CustomRender)

/// 渲染自渲染广告视图，在调用之前需确保frame正确
- (void)customRender;

@end

NS_ASSUME_NONNULL_END
