//
// Created by heyinyin on 2022/4/21.
// Copyright (c) 2022 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroMore.h"

@interface ABUDrawAdView (CustomRender)

/// 渲染自渲染广告视图，在调用之前需确保frame正确
- (void)customRender;

@end
