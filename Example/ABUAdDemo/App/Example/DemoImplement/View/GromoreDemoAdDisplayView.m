//
//  GromoreDemoAdDisplayView.m
//  ABUDemo
//
//  Created by bytedance on 2022/2/15.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "GromoreDemoAdDisplayView.h"
#import "GromoreDemoCustomDefine.h"

@implementation GromoreDemoAdDisplayView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    [@"此处用于展示banner广告" drawInRect:CGRectMake(0, 30, CGRectGetWidth(self.frame), 30) withAttributes:@{
        NSFontAttributeName : GROMORE_PingFangSC_Font(16),
        NSForegroundColorAttributeName : [GROMORE_666666_Color colorWithAlphaComponent:0.5],
        NSParagraphStyleAttributeName : style
    }];
}

@end
