//
//  UIView+Draw.m
//  BUAdSDKDemo
//
//  Created by iCuiCui on 2018/10/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "UIView+Draw.h"

@implementation UIView (Draw)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGSize)size {
    return self.frame.size;
}

@end
