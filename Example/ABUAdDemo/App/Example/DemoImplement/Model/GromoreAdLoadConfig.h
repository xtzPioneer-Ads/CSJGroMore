//
//  GromoreAdLoadConfig.h
//  ABUDemo
//
//  Created by bytedance on 2022/2/10.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GromoreAdType) {
    GromoreAdTypeBanner = 1,
    GromoreAdTypeInterstitial = 2,
    GromoreAdTypeSplash = 3,
    GromoreAdTypeNative = 5,
    GromoreAdTypeRewardedVideo = 7,
    GromoreAdTypeFullscreenVideo = 8,
    GromoreAdTypeInterstitialPro = 10,
    GromoreAdTypeDraw = 11
};

@interface GromoreAdLoadConfig : NSObject

@property (nonatomic, copy) NSString *slotID;

@property (nonatomic, assign) GromoreAdType adType;

@property (nonatomic, copy) NSString *adDesc;

@property (nonatomic, copy, readonly) NSString *adTypeName;

/// Native/Banner/draw专用
@property (nonatomic, assign) CGSize adSize;

@end

NS_ASSUME_NONNULL_END
