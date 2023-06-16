//
//  ABUDemoAdHandleCell.h
//  ABUDemo
//
//  Created by heyinyin on 2021/12/15.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GromoreDemoCustomDefine.h"
#import "GromoreAdLoadParam.h"

NS_ASSUME_NONNULL_BEGIN

@class GromoreDemoAdHandleCell;

@protocol GromoreDemoAdHandleDelegate <NSObject>

- (void)showConsole:(BOOL)ifShowConsole;

- (void)loadButtonDidClick:(GromoreDemoAdHandleCell *)sender;

- (void)showButtonDidClick:(GromoreDemoAdHandleCell *)sender;

@end

@interface GromoreDemoAdHandleCell : UITableViewCell

@property (nonatomic, weak) id<GromoreDemoAdHandleDelegate>delegate;

@property (nonatomic, assign, readonly) BOOL showAdAfterLoad;

- (void)changeAdStatus:(GromoreDemoAdStatus)adStatus;
@end

NS_ASSUME_NONNULL_END
