//
//  GMMethod.h
//  GMLog
//
//  Created by Mac on 2021/12/19.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@class GMMethod;

typedef struct objc_method_description GMMethodDescription;

GMMethod *
GMMethodFromMethod(Method method);

GMMethod *
GMMethodFromMethodDescription(GMMethodDescription description);

@interface GMMethod : NSObject

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, assign, readonly) SEL sel;

@property (nonatomic, assign, readonly) IMP imp;

@property (nonatomic, copy, readonly) NSString *typeEncoding;

@end

NS_ASSUME_NONNULL_END
