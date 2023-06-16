//
//  UIImageView+GMDemo.m
//  ABUDemo
//
//  Created by bytedance on 2022/9/26.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "UIImageView+GMDemo.h"

@protocol GMImageViewProtocol <NSObject>

- (void)sdBu_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder;

@end

@interface UIImageView () <GMImageViewProtocol>

@end

@implementation UIImageView (GMDemo)


static NSMutableDictionary<NSString *, UIImage *> *_gm_cached_images;

static NSLock *_gm_image_lock;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage {
    if ([self respondsToSelector:@selector(sdBu_setImageWithURL:placeholderImage:)]) {
        [self sdBu_setImageWithURL:url placeholderImage:placeholderImage];
    } else {
        [self _gm_setImageWithURL:url placeholderImage:placeholderImage];
    }
}

- (void)_gm_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage {
    [self gm_setupCacheMap];
    placeholderImage ? self.image = placeholderImage : (void *)0;
    if (!url) return;
    NSString *urlString = url.absoluteString;
    __block UIImage *image = [_gm_cached_images valueForKey:urlString];
    if (image) {
        self.image = image;
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        image = [UIImage imageWithData:data];
        if (!image) return;
        [_gm_image_lock lock];
        [_gm_cached_images setValue:image forKey:urlString];
        [_gm_image_lock unlock];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    });
}

- (void)gm_setupCacheMap {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _gm_cached_images = [NSMutableDictionary dictionary];
        _gm_image_lock = [[NSLock alloc] init];
    });
}


@end
