//
//  ABUDCustomNativeAdHelper.h
//  ABUDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroMore.h"
@class ABUDCustomNativeData;

NS_ASSUME_NONNULL_BEGIN

@interface ABUDCustomNativeAdHelper : NSObject <ABUMediatedNativeAdData, ABUMediatedNativeAdViewCreator>

- (instancetype)initWithAdData:(ABUDCustomNativeData *)data;

@end

NS_ASSUME_NONNULL_END
