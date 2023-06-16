//
//  ABUDCustomBannerView.h
//  ABUDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUDCustomBannerView : UIButton

@property (nonatomic, copy) void(^didMoveToSuperViewCallback)(ABUDCustomBannerView *view);

@property (nonatomic, copy) void(^closeAction)(ABUDCustomBannerView *view);

@end

NS_ASSUME_NONNULL_END
