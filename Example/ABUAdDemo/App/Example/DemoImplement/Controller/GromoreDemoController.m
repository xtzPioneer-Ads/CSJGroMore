//
//  ViewController.m
//  Ads-Mediation-CN-demo
//
//  Created by heyinyin on 2021/12/30.
//

#import "GromoreDemoController.h"
#import "GromoreDemoController+ad.h"
#import "GromoreDemoAdDisplayView.h"
#import "GromoreDemoDeviceInfoView.h"
#import <objc/runtime.h>

@interface GromoreDemoController () <GromoreDemoLoadAdViewDelegate>

@property (nonatomic, strong) GromoreDemoLoadAdView *adView;

@property (nonatomic, copy) GromoreAdLoadConfig *currentAdConfig;

@property (nonatomic, strong) UIImageView *navigationBottomLine;
@end

@implementation GromoreDemoController

- (void)loadView {
    _adView = [[GromoreDemoLoadAdView alloc] init];
    _adView.delegate = self;
    __weak typeof(self) ws = self;
    _adView.updateTitleAction = ^(NSString *title) {
        __strong typeof(ws) self = ws;
        UILabel *titleView = (UILabel *)self.navigationItem.titleView;
        titleView.text = title;
        [titleView sizeToFit];
    };
    self.view = self.adView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigation];
}

- (void)setupNavigation {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = GROMORE_666666_Color;
    titleLabel.font = GROMORE_PingFangSC_Semibold_Font(20);
    titleLabel.text = @"开始测试广告吧";
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;

    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = GROMORE_PingFangSC_Font(12);
    [btn setTitle:[ABUAdSDKManager SDKVersion] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(showDeviceInfo:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *subViews = [self allSubviews:self.navigationController.navigationBar];
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height < 1) {
            self.navigationBottomLine =  (UIImageView *)view;
        }
    }
    self.navigationBottomLine.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    self.navigationBottomLine.hidden = NO;
}

- (NSArray *)allSubviews:(UIView *)aView {
    NSArray *results = [aView subviews];
    for (UIView *eachView in aView.subviews) {
        NSArray *subviews = [self allSubviews:eachView];
        if (subviews) {
            results = [results arrayByAddingObjectsFromArray:subviews];
        }
    }
    return results;
}

- (UIView *)adBackView {
    return _adView.backView;
}

- (void)showDeviceInfo:(UIButton *)sender {
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [GromoreDemoDeviceInfoView show];
}

- (void)showAdView:(UIView *(^)(CGSize size))viewBlock {
    GromoreDemoAdDisplayView *view = (GromoreDemoAdDisplayView *)self.adBackView;
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (!viewBlock) return;
    UIView *v = viewBlock(view.frame.size);
    v ? [view addSubview:v] : (void*)0;
}


- (void)adStatusChanged:(GromoreDemoAdStatus)status {
    [_adView adStatusChanged:status];
}

#pragma mark ----- GromoreDemoLoadAdViewDelegate -----
#pragma mark ----- 广告加载 -----
- (void)startLoadAdWithConfig:(GromoreAdLoadConfig *)config andParam:(GromoreAdLoadParam *)param {
    
    /// 阻断之前广告代理
    [self removeAdBinding:config.adTypeName];
    
    /// 开始处理新广告
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"load%@AdWithConfig:andParam:", config.adTypeName]);
    
    
    NSString *message = nil;
    if (!config) message = @"请先选择广告类型及广告位ID";
    if (!message && ![self respondsToSelector:sel]) message = @"控制器无法响应广告加载方法";
    
    if (message) {
        /// 错误警告
        [self alertWarningWithMessage:message];
        return;
    }
    
    _currentAdConfig = config;
    _showAdAfterLoad = param.showAfterLoad;
    
    IMP imp = class_getMethodImplementation(self.class, sel);
    if ([self respondsToSelector:sel]) {
        [self showAdView:nil];
        config.adSize = self.adBackView.frame.size;
        ((void(*)(id, SEL, GromoreAdLoadConfig *, GromoreAdLoadParam *))imp)(self, sel, config, param);
        [self loadExtra];
    }
}

/// 阻断之前广告代理
- (void)removeAdBinding:(NSString *)adTypeName {
    SEL delDelegate = NSSelectorFromString([NSString stringWithFormat:@"reset%@Ad", adTypeName]);
    IMP resetImp = class_getMethodImplementation(self.class, delDelegate);
    if ([self respondsToSelector:delDelegate]) {
        ((void(*)(id, SEL))resetImp)(self, delDelegate);
    }
}

/// 错误警告
- (void)alertWarningWithMessage:(NSString *)message {
    if (message.length <= 0) return;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"⚠️警告" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark ----- 广告展示 -----
- (void)startShowAd {
    
    GromoreAdLoadConfig *config = _currentAdConfig;
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"show%@Ad", config.adTypeName]);
    
    NSString *message = nil;
    if (!config) message = @"请先选择广告类型及广告位ID加载广告后再展示";
    if (!message && ![self respondsToSelector:sel]) message = @"控制器无法响应广告展示方法";
    
    if (message) {
        [self alertWarningWithMessage:message];
        return;
    }

    IMP imp = class_getMethodImplementation(self.class, sel);
    if ([self respondsToSelector:sel]) {
        [self showAdView:nil];
        config.adSize = self.adBackView.frame.size;
        ((void(*)(id, SEL, BOOL))imp)(self, sel, NO);
    }
}

#pragma mark 广告状态及view联动处理
/// 父类方法
- (void)loadExtra {
    [_adView adStatusChanged:GromoreDemoAdStatusLoading];
}

- (void)loadedExtra {
    [_adView adStatusChanged:GromoreDemoAdStatusLoaded];
    if (self.showAdAfterLoad) {
        [self autoShowAd];
    }
}

- (void)loadFailedExtra {
    [_adView adStatusChanged:GromoreDemoAdStatusLoadFailed];
}

- (void)autoShowAd {
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"show%@Ad", _currentAdConfig.adTypeName]);
    if (![self respondsToSelector:sel]) return;

    IMP imp = class_getMethodImplementation(self.class, sel);
    if ([self respondsToSelector:sel]) {
        [self showAdView:nil];
        _currentAdConfig.adSize = self.adBackView.frame.size;
        ((void(*)(id, SEL))imp)(self, sel);
    }
}

- (void)closeExtra {
    [self showAdView:nil];
}

@end
