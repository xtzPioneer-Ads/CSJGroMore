//
//  GromoreDemoDeviceInfoView.m
//  ABUDemo
//
//  Created by bytedance on 2022/2/15.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "GromoreDemoDeviceInfoView.h"
#import <AdSupport/AdSupport.h>
#import "GromoreDemoCustomDefine.h"

/// 可视化测试工具
#import <ABUVisualDebug/ABUVisualDebug.h>

@interface GromoreDemoDeviceInfoView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, copy) NSArray *list;

@end

@implementation GromoreDemoDeviceInfoView

+ (void)show {
    CGRect frame = [UIScreen mainScreen].bounds;
    GromoreDemoDeviceInfoView *view = [[GromoreDemoDeviceInfoView alloc] initWithFrame:frame];
    [[self mainWindow] addSubview:view];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupData];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    CGFloat width = self.frame.size.width * 0.8f;
    CGRect frame = CGRectMake(0, 0, width, width);
    
    self.contentView = [[UIView alloc] initWithFrame:frame];
    self.contentView.center = CGPointMake(self.frame.size.width * .5f, self.frame.size.height * 0.4f);
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 4.f;
    self.contentView.clipsToBounds = YES;
    [self addSubview:self.contentView];
    
    CGRect tvFrame = CGRectMake(0, 20, width, width - 20);
    self.tableView = [[UITableView alloc] initWithFrame:tvFrame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.contentView addSubview:self.tableView];
    
    self.closeButton = [[UIButton alloc] init];
    [self.closeButton setTitle:@" X " forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.closeButton.titleLabel.font = GROMORE_PingFangSC_Font(12);
    [self.closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.closeButton];
    [self.closeButton sizeToFit];
    self.closeButton.frame = CGRectOffset(self.closeButton.frame, width - self.closeButton.frame.size.width - 5.f, 5.f);
}

- (void)setupData {
    NSMutableArray *list = [NSMutableArray array];
    [list addObject:@{
        @"title" : @"GroMore",
        @"value" : [NSClassFromString(@"ABUAdSDKManager") performSelector:NSSelectorFromString(@"SDKVersion")],
    }];
    [list addObject:@{
        @"title" : @"IDFA",
        @"value" : [self get_idfa],
    }];
    [list addObject:@{
        @"title" : @"IDFV",
        @"value" : [self get_idfv],
    }];
    [list addObject:@{
        @"title" : @"测试工具入口"
    }];
    self.list = list.copy;
}

- (NSString *)get_idfv {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)get_idfa {
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 14.0) {
        if ([ASIdentifierManager.sharedManager isAdvertisingTrackingEnabled]) {
            return [ASIdentifierManager.sharedManager advertisingIdentifier].UUIDString;
        } else {
            return nil;
        }
    } else {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
}

- (void)closeAction {
    [self removeFromSuperview];
}

+ (UIWindow *)mainWindow {
    UIWindow *window = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        window = [[UIApplication sharedApplication].delegate window];
    }
    if (![window isKindOfClass:[UIView class]]) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    return window;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.list[indexPath.row];
    NSString *title = dict[@"title"];
    NSString *value = dict[@"value"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = title;
    cell.detailTextLabel.text = value;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
        /// 开启可视化测试工具
        [self startTestTool];
        return;
    }
    
    NSDictionary *dict = self.list[indexPath.row];
    NSString *title = dict[@"title"];
    NSString *value = dict[@"value"];
    
    [[UIPasteboard generalPasteboard] setString:value];
    Class cls = NSClassFromString(@"ABUToastView");
    if ([cls respondsToSelector:@selector(showWithTitle:)]) {
        [cls performSelector:@selector(showWithTitle:) withObject:[title stringByAppendingString:@"已复制"]];
    }
}

#pragma mark 开启可视化测试工具
- (void)startTestTool {
    
    BOOL result = [ABUVisualDebug startVisualDebug];
    if (!result) {
        NSLog(@"可视化工具初始化失败,请检查配置 ~ ");
    }
}

@end
