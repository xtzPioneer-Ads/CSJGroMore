//
//  ABUDemoAdStatusInfoCell.m
//  ABUDemo
//
//  Created by heyinyin on 2021/12/15.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "GromoreDemoAdStatusCell.h"
#import "GromoreDemoAdCallbackCell.h"

NSString *const GromoreDemoAdStatusCellReviceRecordNotification = @"GromoreDemoAdStatusCellReviceRecordNotification";

NSString *const GromoreDemoAdStatusCellReviceClearNotification = @"GromoreDemoAdStatusCellReviceClearNotification";

NSString *const GromoreDemoAdStatusCellReviceRecordKey = @"record";

static NSString *adSelectCell = @"GROMORE_DEMO_CALLBACK_CELL";

@interface GromoreDemoAdStatusCell () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation GromoreDemoAdStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initTableView];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRecord:) name:GromoreDemoAdStatusCellReviceRecordNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveClear:) name:GromoreDemoAdStatusCellReviceClearNotification object:nil];
    return self;
}

- (void)initTableView {
    if (!_tableView) {
        CGRect frame = (CGRect){0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 220}; // _basicInfo.count
        
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:_tableView];
        [_tableView registerClass:[GromoreDemoAdCallbackCell class] forCellReuseIdentifier:adSelectCell];
    }
}

#pragma mark ---- UITableViewDelegate, UITableViewDataSource ----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GromoreDemoAdCallbackCell *cell = (GromoreDemoAdCallbackCell *)[tableView dequeueReusableCellWithIdentifier:adSelectCell];
    NSString *text = self.list[indexPath.row];
    [cell setCallbackRecord:text];
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
    return 40.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 处理点击事件,显示对应选择广告信息
}

#pragma mark - Notice
- (void)didReceiveRecord:(NSNotification *)notification {
    NSString *record = notification.userInfo[GromoreDemoAdStatusCellReviceRecordKey];
    [self.list addObject:record];
    [self reloadTableView];
}

- (void)didReceiveClear:(NSNotification *)notification {
    if (self.list.count > 0) {
        [self.list removeAllObjects];
        [self reloadTableView];
    }
}

- (void)reloadTableView {
    [self.tableView reloadData];
}

#pragma mark - Getter && Setter

- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

@end
