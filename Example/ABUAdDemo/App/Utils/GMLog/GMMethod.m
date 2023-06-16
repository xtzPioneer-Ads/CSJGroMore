//
//  GMMethod.m
//  GMLog
//
//  Created by Mac on 2021/12/19.
//

#import "GMMethod.h"

@implementation GMMethod

- (instancetype)init { return nil; }

- (instancetype)initWithMethod:(Method)method {
    if (method == NULL) return nil;
    if (self = [super init]) {
        _sel = method_getName(method);
        _imp = method_getImplementation(method);
        _name = NSStringFromSelector(_sel);
        _typeEncoding = [NSString stringWithCString:method_getTypeEncoding(method) encoding:NSUTF8StringEncoding];
    }
    return self;
}

- (instancetype)initWithMethodDescription:(GMMethodDescription)description {
    if (description.name == NULL) return nil;
    if (description.types == NULL) return nil;
    if (self = [super init]) {
        _sel = description.name;
        _name = NSStringFromSelector(_sel);
        _typeEncoding = [NSString stringWithCString:description.types encoding:NSUTF8StringEncoding];
    }
    return self;
}

@end

GMMethod *
GMMethodFromMethod(Method method) {
    return [[GMMethod alloc] initWithMethod:method];
}

GMMethod *
GMMethodFromMethodDescription(GMMethodDescription description) {
    return [[GMMethod alloc] initWithMethodDescription:description];
}
