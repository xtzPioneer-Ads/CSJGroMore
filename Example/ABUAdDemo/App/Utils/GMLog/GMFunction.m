//
//  GMFunction.m
//  GMLog
//
//  Created by Mac on 2021/12/19.
//

#import "GMFunction.h"

@interface GMFunction ()

@property (nonatomic, assign) IMP CFunction;

@end

@implementation GMFunction

- (instancetype)initWithCFunction:(void (*)(void))CFunction {
    if (self = [super init]) {
        _CFunction = CFunction;
    }
    return self;
}

@end
