//
//  GMMethodPrepare.h
//  GMLog
//
//  Created by Mac on 2021/12/19.
//

#import <Foundation/Foundation.h>
#import "GMLogManager.h"
#import "GMFunction.h"

NS_ASSUME_NONNULL_BEGIN

static NSMutableDictionary<NSString *, GMFunction *> *gm_imp_map;

static void gromore_imp_1_0(id self, SEL _cmd, id arg0);
static void gromore_imp_2_0(id self, SEL _cmd, id arg0, id arg1);
static void gromore_imp_3_0(id self, SEL _cmd, id arg0, id arg1, id arg2);
static void gromore_imp_3_d(id self, SEL _cmd, id arg0, id arg1, long arg2);

// gromore_imp_[tc]_[bc]

static inline NSString *
gromore_imp_key(id self, SEL _cmd) {
//    NSString *a = NSStringFromClass([self class]);
    NSString *b = NSStringFromSelector(_cmd);
    NSString *key = [NSString stringWithFormat:@"- %@", b];
    return key;
}

static inline bool
gromore_register_method(Class clazz, Method method) {
    IMP imp = method_getImplementation(method);
    SEL sel = method_getName(method);
    NSString *key = gromore_imp_key((id)clazz, sel);
    static dispatch_once_t onceToken;
    static NSDictionary *_encodingImpMap = nil;
    dispatch_once(&onceToken, ^{
        gm_imp_map = [NSMutableDictionary dictionary];
        _encodingImpMap = @{
            @"v24@0:8@16" : [[GMFunction alloc] initWithCFunction:(IMP)&gromore_imp_1_0],
            @"v32@0:8@16@24" : [[GMFunction alloc] initWithCFunction:(IMP)&gromore_imp_2_0],
            @"v40@0:8@16@24@32" : [[GMFunction alloc] initWithCFunction:(IMP)&gromore_imp_3_0],
            @"v40@0:8@16@24d32" : [[GMFunction alloc] initWithCFunction:(IMP)&gromore_imp_3_d],
        };
    });
    if (gm_imp_map[key]) return true;
    gm_imp_map[key] = [[GMFunction alloc] initWithCFunction:imp];
    
    NSString *encoding = [NSString stringWithUTF8String:method_getTypeEncoding(method)];
    IMP simp = [[_encodingImpMap objectForKey:encoding] CFunction];
    if (!simp) return false;
    method_setImplementation(method, simp);
    return true;
}

static void
gromore_imp_1_0(id self, SEL _cmd, id arg0) {
    NSString *key = gromore_imp_key(self, _cmd);
    GMFunction *function = gm_imp_map[key];
    if (function == nil) return;
    [GMLogManager logWithInvocation:({
        GMInvocation *invocation = [[GMInvocation alloc] init];
        invocation.target = self;
        invocation.selector = _cmd;
        NSMutableArray *args = [NSMutableArray arrayWithCapacity:1];
        [args addObject:arg0 ?: [NSNull null]];
        invocation.args = args.copy;
        invocation;
    }) andMessage:@"%@", key];
    
    IMP imp = function.CFunction;
    ((void(*)(id, SEL, id))imp)(self, _cmd, arg0);
}

static void
gromore_imp_2_0(id self, SEL _cmd, id arg0, id arg1) {
    NSString *key = gromore_imp_key(self, _cmd);
    GMFunction *function = gm_imp_map[key];
    if (function == nil) return;
    [GMLogManager logWithInvocation:({
        GMInvocation *invocation = [[GMInvocation alloc] init];
        invocation.target = self;
        invocation.selector = _cmd;
        NSMutableArray *args = [NSMutableArray arrayWithCapacity:2];
        [args addObject:arg0 ?: [NSNull null]];
        [args addObject:arg1 ?: [NSNull null]];
        invocation.args = args.copy;
        invocation;
    }) andMessage:@"%@", key];
    
    IMP imp = function.CFunction;
    ((void(*)(id, SEL, id, id))imp)(self, _cmd, arg0, arg1);
}

static void
gromore_imp_3_0(id self, SEL _cmd, id arg0, id arg1, id arg2) {
    NSString *key = gromore_imp_key(self, _cmd);
    GMFunction *function = gm_imp_map[key];
    if (function == nil) return;
    [GMLogManager logWithInvocation:({
        GMInvocation *invocation = [[GMInvocation alloc] init];
        invocation.target = self;
        invocation.selector = _cmd;
        NSMutableArray *args = [NSMutableArray arrayWithCapacity:3];
        [args addObject:arg0 ?: [NSNull null]];
        [args addObject:arg1 ?: [NSNull null]];
        [args addObject:arg2 ?: [NSNull null]];
        invocation.args = args.copy;
        invocation;
    }) andMessage:@"%@", key];
    
    IMP imp = function.CFunction;
    ((void(*)(id, SEL, id, id, id))imp)(self, _cmd, arg0, arg1, arg2);
}

static void
gromore_imp_3_d(id self, SEL _cmd, id arg0, id arg1, long arg2) {
    NSString *key = gromore_imp_key(self, _cmd);
    GMFunction *function = gm_imp_map[key];
    if (function == nil) return;
    [GMLogManager logWithInvocation:({
        GMInvocation *invocation = [[GMInvocation alloc] init];
        invocation.target = self;
        invocation.selector = _cmd;
        NSMutableArray *args = [NSMutableArray arrayWithCapacity:2];
        [args addObject:arg0 ?: [NSNull null]];
        [args addObject:arg1 ?: [NSNull null]];
        [args addObject:@(arg2)];
        invocation.args = args.copy;
        invocation;
    }) andMessage:@"%@", key];
    
    IMP imp = function.CFunction;
    ((void(*)(id, SEL, id, id, long))imp)(self, _cmd, arg0, arg1, arg2);
}

NS_ASSUME_NONNULL_END
