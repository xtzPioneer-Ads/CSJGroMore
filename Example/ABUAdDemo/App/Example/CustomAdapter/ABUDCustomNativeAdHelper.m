//
//  ABUDCustomNativeAdHelper.m
//  ABUDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "ABUDCustomNativeAdHelper.h"
#import "ABUDCustomNativeData.h"

@interface ABUDCustomNativeAdHelper ()

@property (nonatomic, strong) ABUDCustomNativeData *data;

@property (nonatomic, strong) UILabel *adTitleLabel;

@property (nonatomic, strong) UIImageView *adImageView;

@end

@implementation ABUDCustomNativeAdHelper

- (instancetype)initWithAdData:(ABUDCustomNativeData *)data {
    if (self = [super init]) {
        _data = data;
        _adTitleLabel = [[UILabel alloc] init];
        _adImageView = [[UIImageView alloc] init];
    }
    return self;
}

#pragma mark - ABUMediatedNativeAdViewCreator
- (UILabel *)titleLabel {
    return self.adTitleLabel;
}

#pragma mark - ABUMediatedNativeAdData
- (NSString *)AdTitle {
    return self.data.title;
}

- (NSString *)AdDescription {
    return self.data.subtitle;
}

- (NSArray<ABUImage *> *)imageList {
    UIImage *image = [UIImage imageNamed:self.data.imageName];
    ABUImage *img = [[ABUImage alloc] init];
    img.width = self.data.imageSize.width;
    img.height = self.data.imageSize.height;
    img.image = image;
    return @[img];
}

- (ABUImage *)adLogo {
    ABUImage *img = [[ABUImage alloc] init];
    img.width = 30;
    img.height = 30;
    img.image = self.data.logoView;
    return img;
}

- (ABUImage *)sdkLogo {
    return self.adLogo;
}

- (ABUMediatedNativeAdMode)imageMode {
    return ABUMediatedNativeAdModeLargeImage;
}
@end
