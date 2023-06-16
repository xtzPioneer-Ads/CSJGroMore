//
//  ABUDemoAdBasicInfoSelectCell.m
//  Ads-Mediation-CN-demo
//
//  Created by heyinyin on 2022/1/28.
//

#import "GromoreDemoAdBasicInfoSelectCell.h"
#import "GromoreDemoCustomDefine.h"

@interface GromoreDemoAdBasicInfoSelectCell ()

@property (nonatomic, strong) UIImageView *image;

@property (nonatomic, strong) UILabel *idLable;

@end

@implementation GromoreDemoAdBasicInfoSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initView {
    CGFloat x = 12.f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 8, 20, 20)];
    
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(3, 4, 12, 8)];
    _idLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view.frame) + x, 7, CGRectGetWidth([UIScreen mainScreen].bounds) - x * 2, 20)];
    _idLable.textColor = GROMORE_333333_Color;
    _idLable.font = GROMORE_PingFangSC_Font(16);
    _idLable.text = @"广告位";
    
    [view addSubview:_image];
    [self.contentView addSubview:_idLable];
    [self.contentView addSubview:view];
}

- (void)setCellInfoWithAdType:(NSString *)adType andAdId:(NSString *)adId {
    _idLable.text = [NSString stringWithFormat:@"%@ - %@", adType, adId];
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _image.image = [UIImage imageNamed:@"gromore_selected"];
        _image.alpha = 1;
        _idLable.alpha = 1;
    } else {
        _image.image = nil;
        _image.alpha = 0.5;
        _idLable.alpha = 0.5;
    }
}

@end
