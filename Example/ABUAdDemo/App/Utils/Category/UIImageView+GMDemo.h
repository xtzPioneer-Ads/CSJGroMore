//
//  UIImageView+GMDemo.h
//  ABUDemo
//
//  Created by bytedance on 2022/9/26.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (GMDemo)

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
