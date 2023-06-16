//
//  UIViewController+GMLog.m
//  GMLog
//
//  Created by Mac on 2021/12/19.
//

#import "UIViewController+GMLog.h"
#import "GMLogViewController.h"
#import <objc/runtime.h>
#import "GMMethod.h"

@interface UIViewController (GMLog)

@end

@implementation UIViewController (GMLog)

+ (void)load {
    Method method1 = class_getInstanceMethod(self.class, @selector(viewDidLoad));
    Method method2 = class_getInstanceMethod(self.class, @selector(gm_viewDidLoad));
    method_exchangeImplementations(method1, method2);
}

- (void)gm_viewDidLoad {
    NSString *className = NSStringFromClass(self.class);
    BOOL didHandle = [[self class] gm_logMap][className] != nil;
    if (didHandle) {
        [self setLogEnable:YES];
        [self gm_viewDidLoad];
        return;
    }
    BOOL conforms = [self conformsToProtocol:@protocol(GMLogViewController)];
    if (conforms) {
        [self setLogEnable:YES];
        [self _handle];
    }
    [self gm_viewDidLoad];
}

#pragma mark - Private
- (NSArray<GMMethod *> *)_copyProtocolMethodsWithTarget:(id<GMLogViewController>)target {
    NSArray<Protocol *> *protocols = [target logMethodsInProtocols];
    NSMutableArray<GMMethod *> *list = [NSMutableArray array];
    [protocols enumerateObjectsUsingBlock:^(Protocol * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        unsigned int count = 0;
        struct objc_method_description *descs;
        descs = protocol_copyMethodDescriptionList(obj, NO, YES, &count);
        for (int i = 0; i < count; i++) {
            struct objc_method_description desc = descs[i];
            GMMethod *m = GMMethodFromMethodDescription(desc);
            if (m) [list addObject:m];
        }
        
        descs = protocol_copyMethodDescriptionList(obj, YES, YES, &count);
        for (int i = 0; i < count; i++) {
            struct objc_method_description desc = descs[i];
            GMMethod *m = GMMethodFromMethodDescription(desc);
            if (m) [list addObject:m];
        }
        free(descs);
    }];
    return [list copy];
}

- (void)_handle {
    UIViewController<GMLogViewController> *vc = (UIViewController<GMLogViewController> *)self;
    NSArray<GMMethod *> *list = [self _copyProtocolMethodsWithTarget:vc];
    [list enumerateObjectsUsingBlock:^(GMMethod * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL sel = obj.sel;
        if ([vc respondsToSelector:sel]) {
            Method method = class_getInstanceMethod(vc.class, sel);
            BOOL success = [vc prepareLogForMethod:method];
            if (!success) NSLog(@"can not log Method %s", sel_getName(sel));
        }
    }];
}

#pragma mark - Getter && Setter
+ (NSMutableDictionary<NSString *, NSString *> *)gm_logMap {
    static NSMutableDictionary *_gm_logMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _gm_logMap = [NSMutableDictionary dictionary];
    });
    return _gm_logMap;
}

- (BOOL)logEnable {
    return [objc_getAssociatedObject(self, @selector(logEnable)) boolValue];
}

- (void)setLogEnable:(BOOL)logEnable {
    objc_setAssociatedObject(self, @selector(logEnable), @(logEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
