//
//  ABUDCustomDrawData.h
//  ABUDemo
//
//  Created by ByteDance on 2022/5/6.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUDCustomDrawData : NSObject

+ (instancetype)randomData;

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, copy, readonly) NSString *subtitle;

@property (nonatomic, strong, readonly) UIImage *logoView;

- (void)registerClickableViews:(NSArray<UIView *> *)views;

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, copy) void(^didClickAction)(ABUDCustomDrawData *data);

@end

NS_ASSUME_NONNULL_END
