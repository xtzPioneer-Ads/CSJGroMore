//
//  GromoreDemoAdCallbackCell.m
//  Ads-Mediation-CN-demo
//
//  Created by heyinyin on 2022/2/8.
//

#import "GromoreDemoAdCallbackCell.h"
#import "GromoreDemoCustomDefine.h"

@interface GromoreDemoAdCallbackCell ()

@property (nonatomic, strong) UILabel *callbackLable;

@end

@implementation GromoreDemoAdCallbackCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initView {
    _callbackLable = [[UILabel alloc] init];
    _callbackLable.textColor = GROMORE_666666_Color;
    _callbackLable.font = GROMORE_PingFangSC_Font(12);
    
    [self.contentView addSubview:_callbackLable];
}

- (void)setCallbackRecord:(NSString *)record {
    _callbackLable.text = record;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.contentView.bounds;
    frame.origin = CGPointMake(15, 10);
    frame.size = CGSizeMake(frame.size.width - 15 * 2, frame.size.height - 10 * 2);
    _callbackLable.frame = frame;
}

@end
