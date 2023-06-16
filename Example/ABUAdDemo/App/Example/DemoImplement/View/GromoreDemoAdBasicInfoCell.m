//
//  ABUDemoBasicInfoCell.m
//  ABUDemo
//
//  Created by heyinyin on 2021/12/15.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "GromoreDemoAdBasicInfoCell.h"
#import "GromoreDemoAdBasicInfoSelectCell.h"
#import "GromoreAdLoadConfig.h"

static NSString *adSelectCell = @"GROMORE_DEMO_BASIC_INFO_SELECT_CELL";

@interface GromoreDemoAdBasicInfoCell () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

// 广告基本信息
@property (nonatomic, copy) NSArray<GromoreAdLoadConfig *> *adBasicInfo;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GromoreDemoAdBasicInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self info];
        [self initTableView];
    }
    return self;
}

- (NSArray *)adSlotInfoList {
    return @[
        @{ @"slotID" : @"945494739" , @"adType" : @(GromoreAdTypeRewardedVideo) , @"adDesc" : @"激励视频广告" },
        @{ @"slotID" : @"945494751" , @"adType" : @(GromoreAdTypeFullscreenVideo) , @"adDesc" : @"全屏视频广告" },
        @{ @"slotID" : @"945494755" , @"adType" : @(GromoreAdTypeInterstitial) , @"adDesc" : @"插屏广告" },
        @{ @"slotID" : @"946961656" , @"adType" : @(GromoreAdTypeInterstitialPro) , @"adDesc" : @"插全屏广告" },
        @{ @"slotID" : @"887418500" , @"adType" : @(GromoreAdTypeSplash) , @"adDesc" : @"开屏广告" },
        @{ @"slotID" : @"945494753" , @"adType" : @(GromoreAdTypeBanner) , @"adDesc" : @"Banner广告" },
        @{ @"slotID" : @"945494759" , @"adType" : @(GromoreAdTypeNative) , @"adDesc" : @"信息流-模板" },
        @{ @"slotID" : @"948423177" , @"adType" : @(GromoreAdTypeDraw) , @"adDesc" : @"draw信息流" }
   ];
}

- (void)info {
    NSArray *list = [self adSlotInfoList];
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:list.count];
    [list enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GromoreAdLoadConfig *config = [[GromoreAdLoadConfig alloc] init];
        config.slotID = obj[@"slotID"];
        config.adType = [obj[@"adType"] integerValue];
        config.adDesc = obj[@"adDesc"];
        [temp addObject:config];
    }];
    self.adBasicInfo = [temp copy];
}

- (void)initTableView {
    if (!_tableView) {
        CGRect frame = (CGRect){0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 35 * 3}; // _basicInfo.count
        
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:_tableView];
        [_tableView registerClass:[GromoreDemoAdBasicInfoSelectCell class] forCellReuseIdentifier:adSelectCell];
    }
}

#pragma mark ---- UITableViewDelegate, UITableViewDataSource ----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GromoreDemoAdBasicInfoSelectCell *cell = (GromoreDemoAdBasicInfoSelectCell *)[tableView dequeueReusableCellWithIdentifier:adSelectCell];
    if (_adBasicInfo.count > indexPath.row) {
        GromoreAdLoadConfig *config = [_adBasicInfo objectAtIndex:indexPath.row];
        [cell setCellInfoWithAdType:config.adDesc andAdId:config.slotID];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _adBasicInfo.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 处理点击事件,显示对应选择广告信息
    if (_adBasicInfo.count > indexPath.row) {
        GromoreAdLoadConfig *config = [_adBasicInfo objectAtIndex:indexPath.row];
        if ([self.delegate respondsToSelector:@selector(didSelectAdConfig:)]) {
            [self.delegate didSelectAdConfig:config];
        }
    }
}

@end

