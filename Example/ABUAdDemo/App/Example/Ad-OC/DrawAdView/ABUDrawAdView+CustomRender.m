//
// Created by heyinyin on 2022/4/21.
// Copyright (c) 2022 bytedance. All rights reserved.
//

#import "ABUDrawAdView+CustomRender.h"
#import "GromoreDemoCustomDefine.h"
#import "UIImageView+GMDemo.h"

static UIEdgeInsets const gromore_demo_native_padding = { 10, 15, 10, 15 };

@implementation ABUDrawAdView (CustomRender)

- (void)customRender {
    if (self.isExpressAd) return;
    self.backgroundColor = [UIColor whiteColor];
    [self _renderLargeImageWithSize:self.frame.size];
}

- (void)_renderSmallImageWithSize:(CGSize)size {

    CGFloat offsetY = gromore_demo_native_padding.top;
    CGFloat offsetX = gromore_demo_native_padding.left;
    CGFloat limitWidth = size.width - gromore_demo_native_padding.left - gromore_demo_native_padding.right;
    CGFloat limitHeight = size.height - gromore_demo_native_padding.top - gromore_demo_native_padding.bottom;

    // 小图
    ABUImage *image = self.data.imageList.firstObject;
    const CGFloat imageHeight = limitHeight;
    // 获取不到图片尺寸时按照正方形处理，开发者请根据实现需要调整
    const CGFloat imageWidth = imageHeight * (image.height > 0 ? (image.width / image.height) : 1);
    self.imageView.frame = CGRectMake(offsetX, offsetY, imageWidth, imageHeight);
    if (image) {
        [self.imageView setImageWithURL:image.imageURL placeholderImage:image.image];
    }

    offsetX += imageWidth + 10;

    // 标题
    self.titleLabel.text = self.data.adTitle ?: @"[广告标题]";
    self.titleLabel.font = GROMORE_PingFangSC_Font(14);
    self.titleLabel.frame = CGRectMake(offsetX, offsetY, limitWidth - offsetX, GROMORE_PingFangSC_Font(14).lineHeight);

    offsetY += self.titleLabel.frame.size.height + 10;
    // 描述
    NSString *description = self.data.adDescription ?: @"[广告描述]";
    description = [description stringByAppendingFormat:@"\n%@", [self _otherDescInfo]];
    self.descLabel.text = description;
    self.descLabel.font = GROMORE_PingFangSC_Font(12);
    self.descLabel.textColor = GROMORE_333333_Color;
    self.descLabel.numberOfLines = 0;
    self.descLabel.frame = CGRectMake(offsetX, offsetY, limitWidth - offsetX, 0);
    [self.descLabel sizeToFit];

    // 广告标识
    ABUImage *logo = self.data.adLogo;
    if (!self.adLogoView && logo) {
        self.adLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(20, size.height - 20 - gromore_demo_native_padding.bottom, 20, 20)];
        [(UIImageView *)self.adLogoView setImageWithURL:logo.imageURL placeholderImage:logo.image];
        [self addSubview:self.adLogoView];
    } else if (self.adLogoView) {
        if ([self.adLogoView isKindOfClass:[UIImageView class]] && logo) {
            [(UIImageView *)self.adLogoView setImageWithURL:logo.imageURL placeholderImage:logo.image];
        }
        CGRect frame = self.adLogoView.frame;
        CGSize logoSize = frame.size;
        if (CGSizeEqualToSize(logoSize, CGSizeZero)) {
            logoSize = CGSizeMake(20, 20);
        }
        self.adLogoView.frame = CGRectMake(20, size.height - logoSize.height - gromore_demo_native_padding.bottom, logoSize.width, logoSize.height);
        [self addSubview:self.adLogoView];
    }

    // 关闭按钮
    // 物料信息不包含关闭按钮需要自己实现
    if (!self.dislikeBtn) {
        self.dislikeBtn = [[UIButton alloc] init];
        [self.dislikeBtn setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
        [self.dislikeBtn addTarget:self action:@selector(colseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    self.dislikeBtn.frame = CGRectMake(size.width - 20 - 4, 4, 20, 20);

    // 详情按钮
    if (self.hasSupportActionBtn) {
        CGFloat customBtnWidth = 80;
        CGFloat customBtnHeight = 24;
        self.callToActionBtn.frame = CGRectMake(size.width - gromore_demo_native_padding.right - customBtnWidth, size.height - gromore_demo_native_padding.bottom - customBtnHeight, customBtnWidth, customBtnHeight);
        if (self.data.buttonText.length > 0) {
            [self.callToActionBtn setTitle:self.data.buttonText forState:UIControlStateNormal];
        } else {
            [self.callToActionBtn setTitle:@"详情" forState:UIControlStateNormal];
        }
        self.callToActionBtn.backgroundColor = GROMORE_338AFF_Color;
        self.callToActionBtn.titleLabel.font = GROMORE_PingFangSC_Font(14);
        self.callToActionBtn.layer.cornerRadius = 4.f;
        self.callToActionBtn.layer.masksToBounds = YES;
    }

    [self registerClickableViews:@[
            self.titleLabel,
            self.descLabel,
            self.imageView,
            self.callToActionBtn
    ]];
}

- (void)_renderLargeImageWithSize:(CGSize)size {
    [self _renderSmallImageWithSize:size];
}

- (void)colseAction {
    [self removeFromSuperview];
}

- (NSString *)_otherDescInfo {
    NSMutableString *result = [NSMutableString string];
    // 返回不为空表示物料可用
    if (self.data.appPrice.length > 0) {
        NSString *price = [NSString stringWithFormat:@"价格:%@", self.data.appPrice];
        [result appendString:price];
    }
    if (self.data.score > 0) {
        NSString *score = [NSString stringWithFormat:@"评分:%ld", self.data.score];
        [result appendFormat:@"%@%@", result.length ? @":" : @"", score];
    }
    if (self.data.source.length > 0) {
        NSString *source = [NSString stringWithFormat:@"来源:%@", self.data.source];
        [result appendFormat:@"%@%@", result.length ? @":" : @"", source];
    }
    return result.copy;
}

@end
