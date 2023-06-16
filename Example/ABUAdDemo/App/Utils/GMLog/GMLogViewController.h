//
//  GMLogViewController.h
//  GMLog
//
//  Created by Mac on 2021/12/19.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@class GMInvocation;

@protocol GMLogViewController <NSObject>

- (NSArray<Protocol *> *)logMethodsInProtocols;

- (BOOL)prepareLogForMethod:(Method)method;

- (NSString *)willLogInvocation:(GMInvocation *)invocation andMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
