//
//  ABUDemoLoadAdView.h
//  ABUDemo
//
//  Created by heyinyin on 2021/12/15.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GromoreDemoAdHandleCell.h"
#import "GromoreAdLoadConfig.h"
#import "GromoreAdLoadParam.h"

NS_ASSUME_NONNULL_BEGIN


@protocol GromoreDemoLoadAdViewDelegate <NSObject>

- (void)startLoadAdWithConfig:(GromoreAdLoadConfig *)config andParam:(GromoreAdLoadParam *)param;

- (void)startShowAd;
@end

@interface GromoreDemoLoadAdView : UIView

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, weak) id <GromoreDemoLoadAdViewDelegate> delegate;

- (void)adStatusChanged:(GromoreDemoAdStatus)status;

@property (nonatomic, copy) void(^updateTitleAction)(NSString *title);

@end

NS_ASSUME_NONNULL_END
