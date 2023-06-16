//
//  ABURitInfo+Demo.m
//  ABUDemo
//
//  Created by heyinyin on 2022/3/14.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "ABURitInfo+Demo.h"
#import "ABUDMacros.h"

@implementation ABURitInfo (Demo)

- (NSString *)description {
    return [NSString stringWithFormat:@"ecpm:%@ \n platform:%@ \n ritID:%@ \n requestID:%@", self.ecpm, self.adnName, self.slotID, self.requestID ? : @"None"];
}

- (NSString *)debugDescription {
    return self.description;
}

@end
