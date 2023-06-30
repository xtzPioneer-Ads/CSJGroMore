//
//  GroMoreAppDelegate.m
//  ABUDemo
//
//  Created by bytedance on 2022/2/10.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "GroMoreAppDelegate.h"
#import "GroMore.h"
#import "GromoreDemoController.h"
#import "ABUDSlotID.h"

#pragma mark - 3th party sdks
//#import <GoogleMobileAds/GoogleMobileAds.h>
//#import <BaiduMobAdSDK/BaiduMobAdSetting.h>

#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface GroMoreAppDelegate () <ABUSplashAdDelegate>

@property (nonatomic, strong) ABUSplashAd *splashAd;

@end

@implementation GroMoreAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    GromoreDemoController *mainVC = [[GromoreDemoController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
        
#pragma mark 初始化Gromore SDK
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            [self startGromoreSDK];
        }];
    } else {
        [self startGromoreSDK];
    }
    return YES;
}

/// 使用Gromore SDK
- (void)startGromoreSDK {
    // Gromore SDK初始化方法
    [ABUAdSDKManager initSDKWithAppId:@"5000546" config:^ABUUserConfig *(ABUUserConfig *c) {
#ifdef DEBUG
        // 打开日志开关，线上环境请关闭
        c.logEnable = YES;
        // 打开测试模式，线上环境请关闭
        c.testMode = YES;
#endif
        // [可选]设定自定义IDFA，根据实际情况设定
        c.customIDFA = @"00000000-0000-0000-0000-000000000001";
        return c;
    }];
    
    // 隐私配置设置
    [self privateSetting];
    
    // 设定流量分组
    [self userSegmentSetting];
    
    [ABUAdSDKManager setup];
    // [可选]在初始化完毕后调用首次预缓存
    if (NO) { // 如需测试该功能，修改 NO->YES
        [self preloadAdsConfig];
    }
    
    // 广告加载示例请参考 `GromoreDemoController+广告类型.h`
}

// [可选]预缓存广告配置，此处展示预缓存开屏/全屏广告
- (void)preloadAdsConfig {
    // 开屏广告
    ABUSplashAd *splashAd = [[ABUSplashAd alloc] initWithAdUnitID:normal_splash_ID2];
    splashAd.rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    // 可选配置部分，部分配置会影响到复用逻辑，请尽量与使用位置的广告加载配置项内容保存一致
    splashAd.needZoomOutIfCan = YES; // 开启点睛
   
    // 全屏广告
    ABUFullscreenVideoAd *fullscreenVideoAd = [[ABUFullscreenVideoAd alloc] initWithAdUnitID:express_fullscreen_ID];
    // 可选配置部分，部分配置会影响到复用逻辑，请尽量与使用位置的广告加载配置项内容保存一致
    fullscreenVideoAd.mutedIfCan = YES; // 静音
    
    // 预缓存广告对象，是否能够成功预缓存依赖于后台配置中是否开启广告位的预缓存功能！！！
    [ABUAdSDKManager preloadAdsWithInfos:@[splashAd, fullscreenVideoAd] andInterval:2 andConcurrent:2];
}

/// [可选]流量分组设定
- (void)userSegmentSetting {
    ABUUserInfoForSegment *segment = [[ABUUserInfoForSegment alloc] init];
    segment.user_id = @"Please enter your user's Id";
    segment.user_value_group = @"group1";
    segment.age = 19;
    segment.gender = ABUUserInfo_Gender_Male;
    segment.channel = @"Apple";
    segment.sub_channel = @"Apple store";
    segment.customized_id = @{@(1):@"345",// key非string,不合规
                              @"key2":@"good",// 合规,上报
                              @"key3":@(1),// value非string,不合规
                              @"key4":@"123aA-_",// 合规,上报
                              @"key5":@"123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_1",// 长度超100,不合规
                              @"key6":@"123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_",// 合规,上报
                              @"key7":@"123aA-_*",// value包含特殊字符,不合规
    };
    [ABUAdSDKManager setUserInfoForSegment:segment];
}

/// 隐私设置
- (void)privateSetting {
    [ABUPrivacyConfig setPrivacyWithKey:kABUPrivacyForbiddenIDFA andValue:@(0)];
    [ABUPrivacyConfig setPrivacyWithKey:kABUPrivacyForbiddenCAID andValue:@(0)];
    [ABUPrivacyConfig setPrivacyWithKey:kABUPrivacyLimitPersonalAds andValue:@(0)];
    [ABUPrivacyConfig setPrivacyWithKey:kABUPrivacyLongitude andValue:@(115.7)];
    [ABUPrivacyConfig setPrivacyWithKey:kABUPrivacyLatitude andValue:@(39.4)];
}

@end
