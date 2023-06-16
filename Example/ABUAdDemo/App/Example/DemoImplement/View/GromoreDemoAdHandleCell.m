//
//  ABUDemoAdHandleCell.m
//  ABUDemo
//
//  Created by heyinyin on 2021/12/15.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "GromoreDemoAdHandleCell.h"
#import "GromoreDemoCustomDefine.h"

@interface GromoreDemoAdHandleCell ()

// 广告加载流程
@property (nonatomic, strong) UIView *adView;

@property (nonatomic, strong) UIButton *adLoadButton;

@property (nonatomic, strong) UIButton *adShowButton;

@property (nonatomic, strong) UISwitch *showAdAfterAdLoad;

@property (nonatomic, strong) UISwitch *showConsoleWhenAdLoad;
@end

@implementation GromoreDemoAdHandleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)initView {
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat width = (CGRectGetWidth([UIScreen mainScreen].bounds) - x * 3) / 2;
    CGFloat height = 40;
    
    _adLoadButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    _adShowButton = [[UIButton alloc] initWithFrame:CGRectMake(x + width + 10 , y, width, height)];
    _adLoadButton.backgroundColor = GROMORE_338AFF_Color;
    _adShowButton.backgroundColor = GROMORE_338AFF_Color;
    _adLoadButton.clipsToBounds = YES;
    _adShowButton.clipsToBounds = YES;
    _adLoadButton.layer.cornerRadius = 5;
    _adShowButton.layer.cornerRadius = 5;
    [_adLoadButton setTitle:@"加载广告" forState:UIControlStateNormal];
    [_adShowButton setTitle:@"展示广告" forState:UIControlStateNormal];
    [_adLoadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_adShowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_adLoadButton addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
    [_adShowButton addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchUpInside];
    [_adLoadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_adShowButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    _showAdAfterAdLoad = [[UISwitch alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_adLoadButton.frame) + 3, 30, 30)];
    [_showAdAfterAdLoad addTarget:self action:@selector(showAdWhenAdLoadChanged) forControlEvents:UIControlEventTouchUpInside];
    _showAdAfterAdLoad.tintColor = GROMORE_338AFF_Color;
    _showAdAfterAdLoad.transform = CGAffineTransformMakeScale(0.75, 0.75);
    _showAdAfterAdLoad.on = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_showAdAfterAdLoad.frame) + 5, CGRectGetMaxY(_adLoadButton.frame) + 3, 310, 30)];
    label.textColor = GROMORE_666666_Color;
    label.font = GROMORE_PingFangSC_Font(13);
    label.text = @"加载成功后直接展示广告(仅设定除banner&native)";
    label.alpha = 0.7;
    
    // _showConsoleWhenAdLoad = [[UISwitch alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_showAdAfterAdLoad.frame) + 3, 30, 30)];
    // [_showConsoleWhenAdLoad addTarget:self action:@selector(showConsoleChanged) forControlEvents:UIControlEventTouchUpInside];
    // _showConsoleWhenAdLoad.tintColor = GROMORE_338AFF_Color;
    // _showConsoleWhenAdLoad.transform = CGAffineTransformMakeScale(0.75, 0.75);
    // _showConsoleWhenAdLoad.on = NO;
    
    // UILabel *consoleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_showConsoleWhenAdLoad.frame) + 5, CGRectGetMaxY(_showAdAfterAdLoad.frame) + 3, 310, 30)];
    // consoleLabel.textColor = GROMORE_666666_Color;
    // consoleLabel.font = GROMORE_PingFangSC_Font(13);
    // consoleLabel.text = @"控制台内容实时展示";
    // consoleLabel.alpha = 0.7;
    
    [self.contentView addSubview:_adLoadButton];
    [self.contentView addSubview:_adShowButton];
    [self.contentView addSubview:_showAdAfterAdLoad];
    // [self.contentView addSubview:_showConsoleWhenAdLoad];
    [self.contentView addSubview:label];
    // [self.contentView addSubview:consoleLabel];
}

- (void)showConsoleChanged {
    if ([self.delegate respondsToSelector:@selector(showConsole:)]) {
        [self.delegate showConsole:_showConsoleWhenAdLoad.on];
    }
}

- (BOOL)showAdAfterLoad {
    return _showAdAfterAdLoad.on;
}

- (void)showAdWhenAdLoadChanged {
    if ([self showAdAfterLoad]) {
        [self showButtonInteractive:NO];
    } else {
        [self showButtonInteractive:YES];
    }
}

- (void)showButtonInteractive:(BOOL)enable {
    if (enable) {
        [_adShowButton setUserInteractionEnabled:YES];
        _adShowButton.alpha = 1.0;
    } else {
        [_adShowButton setUserInteractionEnabled:NO];
        _adShowButton.alpha = 0.2;
    }
}

- (void)loadAd {
    if ([self.delegate respondsToSelector:@selector(loadButtonDidClick:)]) {
        [self.delegate loadButtonDidClick:self];
    }
}

- (void)showAd {
    if ([self.delegate respondsToSelector:@selector(showButtonDidClick:)]) {
        [self.delegate showButtonDidClick:self];
    }
    if ([self showAdAfterLoad]) {
        NSLog(@"已设定load后直接展示广告，展示按钮功能被禁用");
    }
}

- (void)changeAdStatus:(GromoreDemoAdStatus)adStatus {
    if (![self showAdAfterLoad]) {
        BOOL enable = YES;
        switch (adStatus) {
            case GromoreDemoAdStatusLoading:
                enable = NO;
                break;
            case GromoreDemoAdStatusLoadFailed:
                enable = NO;
                break;
            default:
                break;
        }
        [self showButtonInteractive:enable];
    }
}

@end
