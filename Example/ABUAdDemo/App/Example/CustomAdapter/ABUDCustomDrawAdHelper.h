//
//  ABUDCustomDrawAdHelper.h
//  ABUDemo
//
//  Created by ByteDance on 2022/5/6.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroMore.h"
@class ABUDCustomDrawData;

NS_ASSUME_NONNULL_BEGIN

@interface ABUDCustomDrawAdHelper : NSObject<ABUMediatedNativeAdData, ABUMediatedNativeAdViewCreator>

- (instancetype)initWithAdData:(ABUDCustomDrawData *)data;

@end

NS_ASSUME_NONNULL_END
