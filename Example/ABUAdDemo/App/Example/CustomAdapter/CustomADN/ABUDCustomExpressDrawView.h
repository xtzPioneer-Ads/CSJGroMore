//
//  ABUDCustomExpressDrawView.h
//  ABUDemo
//
//  Created by ByteDance on 2022/5/6.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUDCustomExpressDrawView : UIView

- (instancetype)initWithSize:(CGSize)size;

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, copy, nullable) void(^didClickAction)(ABUDCustomExpressDrawView *view);

@property (nonatomic, copy, nullable) void(^didMoveToSuperViewCallback)(ABUDCustomExpressDrawView *view);

@property (nonatomic, copy, nullable) void(^didClickCloseAction)(ABUDCustomExpressDrawView *view);

@end

NS_ASSUME_NONNULL_END
