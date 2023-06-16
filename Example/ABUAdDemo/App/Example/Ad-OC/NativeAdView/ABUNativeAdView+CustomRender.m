//
//  ABUNativeAdView+Custom_Render.m
//  ABUDemo
//
//  Created by bytedance on 2022/2/11.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "ABUNativeAdView+CustomRender.h"
#import "GromoreDemoCustomDefine.h"
#import "UIImageView+GMDemo.h"

static UIEdgeInsets const gromore_demo_native_padding = { 10, 15, 10, 15 };
static CGFloat const gromore_demo_padding = 5;

@implementation ABUNativeAdView (CustomRender)

- (void)customRender {
    if (self.isExpressAd) return;
    self.backgroundColor = [UIColor whiteColor];
    [self _commonRender];
    CGFloat limitWidth = self.frame.size.width - CGRectGetMaxX(self.iconImageView.frame) - gromore_demo_padding - gromore_demo_native_padding.right;
    CGRect limitFrame = CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.descLabel.frame) + gromore_demo_padding, limitWidth, self.frame.size.height - CGRectGetMaxY(self.descLabel.frame) - 2 * gromore_demo_padding - self.callToActionBtn.frame.size.height - gromore_demo_native_padding.bottom);
    switch (self.data.imageMode) {
        case ABUMediatedNativeAdModeSmallImage:
        case ABUMediatedNativeAdModeLargeImage:
        case ABUMediatedNativeAdModePortraitImage:
            [self _renderSmallImageWithLimitFrame:limitFrame];
            break;
        case ABUMediatedNativeAdModeGroupImage:
            [self _renderGroupImageWithLimitFrame:limitFrame];
            break;
        case ABUMediatedNativeAdModeLandscapeVideo:
        case ABUMediatedNativeAdModePortraitVideo:
            [self _renderVideoWithLimitFrame:limitFrame];
            break;
        default:
            break;
    }
}

- (void)_commonRender {
    // 头像
    [self _fillAvatarWithOrigin:CGPointMake(gromore_demo_native_padding.left, gromore_demo_native_padding.top)];
    // 标题
    CGFloat limitWidth = self.frame.size.width - CGRectGetMaxX(self.iconImageView.frame) - gromore_demo_padding - gromore_demo_native_padding.right;
    [self _fillTitleWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + gromore_demo_padding, gromore_demo_native_padding.top, limitWidth, self.iconImageView.frame.size.height)];
    // 关闭
    [self _fillCloseButtonWithFrame:CGRectMake(self.frame.size.width - gromore_demo_native_padding.right - 24, gromore_demo_native_padding.top, 24, 24)];
    // 描述
    [self _fillBodyWithFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame) + gromore_demo_padding, limitWidth, 0)];
    // 广告标识
    [self _fillLogoWithFrame:CGRectMake(gromore_demo_native_padding.left, self.frame.size.height - gromore_demo_native_padding.bottom - 24, 24, 24)];
    // 详情按钮
    [self _fillDetailButtonWithTail:CGPointMake(self.frame.size.width - gromore_demo_native_padding.right, self.frame.size.height - gromore_demo_native_padding.bottom)];
}

// 广告app图标
- (void)_fillAvatarWithOrigin:(CGPoint)origin {
    if (!self.iconImageView) {
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
    }
    ABUImage *image = self.data.icon;
    if (image) {
        [self.iconImageView setImageWithURL:image.imageURL placeholderImage:image.image];
    } else {
        self.iconImageView.backgroundColor = [UIColor lightGrayColor];
    }
    self.iconImageView.layer.cornerRadius = 4.f;
    self.iconImageView.clipsToBounds = YES;
    self.iconImageView.frame = (CGRect){origin, CGSizeMake(44, 44)};
}

// 广告标题
- (void)_fillTitleWithFrame:(CGRect)frame {
    self.titleLabel.text = self.data.adTitle ?: self.titleLabel.text ?: @"[广告标题]";
    self.titleLabel.font = GROMORE_PingFangSC_Semibold_Font(14);
    self.titleLabel.textColor = GROMORE_338AFF_Color;
    self.titleLabel.frame = frame;
    [self.titleLabel sizeToFit];
}

// 广告描述
- (void)_fillBodyWithFrame:(CGRect)frame {
    if (self.descLabel.text == nil) {
        self.descLabel.text = self.data.adDescription ?: @"[广告描述]";
    }
    self.descLabel.font = GROMORE_PingFangSC_Font(12);
    self.descLabel.textColor = GROMORE_333333_Color;
    self.descLabel.numberOfLines = 0;
    self.descLabel.frame = frame;
    [self.descLabel sizeToFit];
}

// 广告标识
- (void)_fillLogoWithFrame:(CGRect)frame {
    if (!self.adLogoView) {
        ABUImage *logo = self.data.adLogo;
        self.adLogoView = [[UIImageView alloc] init];
        [(UIImageView *)self.adLogoView setImageWithURL:logo.imageURL placeholderImage:logo.image];
        [self addSubview:self.adLogoView];
        CGFloat width = logo.width;
        CGFloat height = logo.height;
        CGFloat displayHeight = frame.size.height;
        CGFloat displayWidth = frame.size.width;
        if (height != 0) {
            displayWidth = width / height * displayHeight;
        }
        self.adLogoView.frame = (CGRect){frame.origin, CGSizeMake(displayWidth, displayHeight)};
        [self addSubview:self.adLogoView];
    } else {
        CGFloat width = self.adLogoView.frame.size.width;
        CGFloat height = self.adLogoView.frame.size.height;
        CGFloat displayHeight = frame.size.height;
        CGFloat displayWidth = frame.size.width;
        if (height != 0) {
            displayWidth = width / height * displayHeight;
        }
        self.adLogoView.frame = (CGRect){frame.origin, CGSizeMake(displayWidth, displayHeight)};
        if ([self.adLogoView isKindOfClass:[UIImageView class]] && ![(UIImageView *)self.adLogoView image]) {
            ABUImage *logo = self.data.adLogo;
            self.adLogoView = [[UIImageView alloc] init];
            [(UIImageView *)self.adLogoView setImageWithURL:logo.imageURL placeholderImage:logo.image];
        }
    }
}

- (void)_fillCloseButtonWithFrame:(CGRect)frame {
    if (!self.dislikeBtn) {
        self.dislikeBtn = [[UIButton alloc] init];
        [self.dislikeBtn setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
        [self.dislikeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    self.dislikeBtn.frame = frame;
}

- (void)_fillDetailButtonWithTail:(CGPoint)tail {
    // 详情按钮
    if (self.hasSupportActionBtn) {
        CGFloat customBtnWidth = 80;
        CGFloat customBtnHeight = 24;
        self.callToActionBtn.frame = CGRectMake(tail.x - customBtnWidth, tail.y - customBtnHeight, customBtnWidth, customBtnHeight);
        if (self.data.buttonText.length > 0) {
            [self.callToActionBtn setTitle:self.data.buttonText forState:UIControlStateNormal];
        } else {
            [self.callToActionBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        }
        self.callToActionBtn.backgroundColor = GROMORE_338AFF_Color;
        self.callToActionBtn.titleLabel.font = GROMORE_PingFangSC_Font(12);
        self.callToActionBtn.layer.cornerRadius = 4.f;
        self.callToActionBtn.layer.masksToBounds = YES;
    }
}

- (void)_renderSmallImageWithLimitFrame:(CGRect)limitFrame {
    // 小图
    ABUImage *image = self.data.imageList.firstObject;
    CGSize imageSize = [self _maxConstrainSizeWithOriginSize:CGSizeMake(image.width, image.height) andLimitSize:limitFrame.size];
    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        imageSize = limitFrame.size;
    }
    self.imageView.frame = (CGRect){limitFrame.origin, imageSize};
    if (image) {
        [self.imageView setImageWithURL:image.imageURL placeholderImage:image.image];
    }

    [self registerClickableViews:@[
        self.titleLabel,
        self.descLabel,
        self.imageView,
        self.iconImageView,
        self.callToActionBtn
    ]];
}

- (void)_renderGroupImageWithLimitFrame:(CGRect)limitFrame {
    NSInteger count = self.data.imageList.count;
    CGFloat imagePadding = 2;
    CGFloat singleWidth = (limitFrame.size.width - (count - 1) * imagePadding) / count;

    CGFloat offsetX = limitFrame.origin.x;
    CGFloat offsetY = limitFrame.origin.y;

    for (ABUImage *image in self.data.imageList ) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGSize size = [self _maxConstrainSizeWithOriginSize:CGSizeMake(singleWidth, limitFrame.size.height) andLimitSize:limitFrame.size];
        imageView.frame = CGRectMake(offsetX, offsetY, size.width, size.height);
        if (image) {
            [imageView setImageWithURL:image.imageURL placeholderImage:image.image];
        } else {
            imageView.backgroundColor = [UIColor lightGrayColor];
        }
        [self addSubview:imageView];
        offsetX += size.width + imagePadding;
    }
    
    [self registerClickableViews:@[
        self.titleLabel,
        self.descLabel,
        self.iconImageView,
        self.callToActionBtn
    ]];
}

- (void)_renderVideoWithLimitFrame:(CGRect)limitFrame {
    ABUImage *image = self.data.imageList.firstObject;
    CGSize imageSize = [self _maxConstrainSizeWithOriginSize:CGSizeMake(image.width, image.height) andLimitSize:limitFrame.size];
    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        imageSize = limitFrame.size;
    }
    self.mediaView.frame = (CGRect){limitFrame.origin, imageSize};
    self.imageView.hidden = YES;

    [self registerClickableViews:@[
            self.titleLabel,
            self.descLabel,
            self.callToActionBtn,
            self.mediaView
    ]];
}

- (void)closeAction {
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

- (CGSize)_maxConstrainSizeWithOriginSize:(CGSize)size andLimitSize:(CGSize)limitSize {
    if (size.height <= 0 || limitSize.height <= 0) return CGSizeZero;
    CGFloat factor = size.width / size.height;
    CGFloat limitFactor = limitSize.width / limitSize.height;
    if (factor > limitFactor) {
        CGFloat resultWidth = limitSize.width;
        CGFloat resultHeight = resultWidth * factor;
        return CGSizeMake(resultWidth, resultHeight);
    } else {
        CGFloat resultHeight = limitSize.height;
        CGFloat resultWidth = resultHeight * factor;
        return CGSizeMake(resultWidth, resultHeight);
    }
}

@end
