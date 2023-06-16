//
//  GMFunction.h
//  GMLog
//
//  Created by Mac on 2021/12/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMFunction : NSObject

- (instancetype)initWithCFunction:(void(*)(void))CFunction;

- (void(*)(void))CFunction;

@end

NS_ASSUME_NONNULL_END
