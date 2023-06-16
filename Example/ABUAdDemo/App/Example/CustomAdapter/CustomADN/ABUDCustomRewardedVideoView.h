//
//  ABUDCustomRewardedVideoView.h
//  ABUDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUDCustomRewardedVideoView : UIView

+ (instancetype)fullscreenView;

- (void)showInViewController:(UIViewController *)viewController;

@property (nonatomic, copy) void(^dismissCallback)(ABUDCustomRewardedVideoView *view, BOOL skip);

@property (nonatomic, copy) void(^skipCallback)(ABUDCustomRewardedVideoView *view);

@end

NS_ASSUME_NONNULL_END
