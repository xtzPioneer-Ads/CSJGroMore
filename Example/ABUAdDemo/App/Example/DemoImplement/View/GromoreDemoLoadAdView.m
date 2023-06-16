//
//  ABUDemoLoadAdView.m
//  ABUDemo
//
//  Created by heyinyin on 2021/12/15.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "GromoreDemoLoadAdView.h"
#import "GromoreDemoAdBasicInfoCell.h"
#import "GromoreDemoAdStatusCell.h"
#import "GromoreAdLoadConfig.h"
#import "GromoreDemoAdConsoleView.h"
#import "GromoreDemoAdDisplayView.h"
#import "GromoreDemoDeviceInfoView.h"
#import "GroMore.h"

static NSString *adBasicCell = @"GROMORE_DEMO_BASIC_CELL";
static NSString *adHandleCell = @"GROMORE_DEMO_HANDLE_CELL";
static NSString *adStatusCell = @"GROMORE_DEMO_STATUS_CELL";

@interface GromoreDemoLoadAdView () <UITableViewDelegate, UITableViewDataSource, GromoreDemoSelectedAdDelegate, GromoreDemoAdHandleDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *adType;

@property (nonatomic, strong) GromoreAdLoadConfig *adConfig;

@property (nonatomic, strong) GromoreDemoAdConsoleView *consoleView;

@property (nonatomic, strong) GromoreDemoAdHandleCell *handleCell;

@end

@implementation GromoreDemoLoadAdView

- (instancetype)init {
    if (self = [super init]) {
        CGRect frame = [UIScreen mainScreen].bounds;
        self.frame = frame;
        [self initTableviewWithFrame:frame];
        [self initBannerBack];
        [self initConsoleNoticeView];
    }
    return self;
}

- (void)initTableviewWithFrame:(CGRect)frame {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        
        [_tableView registerClass:[GromoreDemoAdBasicInfoCell class] forCellReuseIdentifier:adBasicCell];
        [_tableView registerClass:[GromoreDemoAdHandleCell class] forCellReuseIdentifier:adHandleCell];
        [_tableView registerClass:[GromoreDemoAdStatusCell class] forCellReuseIdentifier:adStatusCell];
        [self addSubview:_tableView];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        CGFloat y = 44;
        CGFloat width = CGRectGetWidth(self.frame);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake( 0, y, width, 32)];

        UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, width, 20)];
        noticeLabel.textColor = GROMORE_666666_Color;
        noticeLabel.font = GROMORE_PingFangSC_Font(10);
        noticeLabel.text = @"点击后选中广告类型及广告位ID";
        [view addSubview:noticeLabel];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = 0.7;

        return view;
    } else {
        return [UIView new];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GromoreDemoAdBasicInfoCell *cell = (GromoreDemoAdBasicInfoCell *)[tableView dequeueReusableCellWithIdentifier:adBasicCell];
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 1) {
        GromoreDemoAdHandleCell *cell = (GromoreDemoAdHandleCell *)[tableView dequeueReusableCellWithIdentifier:adHandleCell];
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 2) {
        GromoreDemoAdStatusCell *cell = (GromoreDemoAdStatusCell *)[tableView dequeueReusableCellWithIdentifier:adStatusCell];
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adHandleCell];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 35 * 3;
        case 1:
            return 120;
        default:
            return 220;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 32;
    }
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 7.0;
}

/// 底部banner展位
- (void)initBannerBack {
    CGFloat height = CGRectGetWidth([UIScreen mainScreen].bounds) * 180 / 414;
    _backView = [[GromoreDemoAdDisplayView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame) - height, CGRectGetWidth(_tableView.frame), height)];
    _backView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];

    [self addSubview:_backView];
}

- (void)initConsoleNoticeView {
    _consoleView = [[GromoreDemoAdConsoleView alloc] init];
    [self addSubview:_consoleView];
}

- (void)adStatusChanged:(GromoreDemoAdStatus)status {
    [_handleCell changeAdStatus:status];
}

- (void)showDeviceInfo:(UIButton *)sender {
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [GromoreDemoDeviceInfoView show];
}

#pragma mark ----- GromoreDemoSelectedAdDelegate -----
- (void)didSelectAdConfig:(GromoreAdLoadConfig *)adConfig {
    _adConfig = adConfig;
    self.updateTitleAction(adConfig.adDesc);
    [self resetCallbackInfo];
}

#pragma mark ----- GromoreDemoAdHandleDelegate -----
- (void)showConsole:(BOOL)ifShowConsole {
    self.consoleView.hidden = !ifShowConsole;
}

- (void)showButtonDidClick:(GromoreDemoAdHandleCell *)sender {
    if ([self.delegate respondsToSelector:@selector(startShowAd)]) {
        [self.delegate startShowAd];
    }
}

- (void)loadButtonDidClick:(GromoreDemoAdHandleCell *)sender {
    [self resetCallbackInfo];
    if ([self.delegate respondsToSelector:@selector(startLoadAdWithConfig:andParam:)]) {
        GromoreAdLoadParam *param = [[GromoreAdLoadParam alloc] init];
        param.showAfterLoad = sender.showAdAfterLoad;
        [self.delegate startLoadAdWithConfig:self.adConfig andParam:param];
        _handleCell = sender;
    }
}

// 重置回调信息栏
- (void)resetCallbackInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:GromoreDemoAdStatusCellReviceClearNotification object:nil userInfo:nil];
}
@end
