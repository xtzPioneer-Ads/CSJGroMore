//
//  ABUDemoBasicInfoCell.h
//  ABUDemo
//
//  Created by heyinyin on 2021/12/15.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GromoreAdLoadConfig;

NS_ASSUME_NONNULL_BEGIN

@protocol GromoreDemoSelectedAdDelegate <NSObject>

- (void)didSelectAdConfig:(GromoreAdLoadConfig *)adConfig;

@end

@interface GromoreDemoAdBasicInfoCell : UITableViewCell

@property (nonatomic, weak)id <GromoreDemoSelectedAdDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
