//
//  GromoreAdLoadParam.h
//  ABUDemo
//
//  Created by bytedance on 2022/2/10.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    GromoreDemoAdStatusNone      = 0,
    GromoreDemoAdStatusLoading,
    GromoreDemoAdStatusLoaded,
    GromoreDemoAdStatusLoadFailed,
    GromoreDemoAdStatusShowFailed
} GromoreDemoAdStatus;

@interface GromoreAdLoadParam : NSObject

/// 是否加载后自动展示
@property (nonatomic, assign) BOOL showAfterLoad;

@end

NS_ASSUME_NONNULL_END
