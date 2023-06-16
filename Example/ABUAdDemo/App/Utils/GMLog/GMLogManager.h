//
//  GMLogManager.h
//  GMLog
//
//  Created by Mac on 2021/12/19.
//

#import <Foundation/Foundation.h>
#import "GMLogViewController.h"
#import "GMInvocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMLogManager : NSObject

+ (void)logWithInvocation:(GMInvocation *)invocation andMessage:(NSString *)message,...;

@end

NS_ASSUME_NONNULL_END
