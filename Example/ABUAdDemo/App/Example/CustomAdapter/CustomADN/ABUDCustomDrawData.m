//
//  ABUDCustomDrawData.m
//  ABUDemo
//
//  Created by ByteDance on 2022/5/6.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "ABUDCustomDrawData.h"
#import "ABUDStoreViewController.h"

@implementation ABUDCustomDrawData

+ (instancetype)randomData {
    static NSSet *set_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set_ = [NSSet setWithObjects:@"竹外🍑🌸三两枝", @"春江水暖🦆先知", @"蒌蒿满地🎋芽短", @"正是河🐡欲上时", nil];
    });
    ABUDCustomDrawData *data = [[ABUDCustomDrawData alloc] init];
    data->_title = @"自定义Draw广告物料展示";
    data->_subtitle = [set_ anyObject];
    data->_logoView = [UIImage imageNamed:@"demo_normal"];
    return data;
}

- (void)registerClickableViews:(NSArray<UIView *> *)views {
    for (UIView *view in views) {
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)]];
    }
}

- (void)didClick {
    if (!self.viewController) return;
    if (self.didClickAction) self.didClickAction(self);
    ABUDStoreViewController *vc = [[ABUDStoreViewController alloc] init];
    [vc openAppStoreWithAppId:@"1142110895" fromViewController:self.viewController complete:^{
        
    }];
}

@end
