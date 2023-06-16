//
//  GMInvocaton.h
//  ABUDemo
//
//  Created by bytedance on 2022/3/10.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMInvocation : NSObject

@property (nonatomic, weak) id target;

@property (nonatomic, copy) NSArray *args;

@property (nonatomic, assign) SEL selector;

@end

NS_ASSUME_NONNULL_END
