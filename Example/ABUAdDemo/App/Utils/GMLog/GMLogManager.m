//
//  GMLogManager.m
//  GMLog
//
//  Created by Mac on 2021/12/19.
//

#import "GMLogManager.h"

@implementation GMLogManager

+ (void)logWithInvocation:(GMInvocation *)invocation andMessage:(NSString *)message, ... {
    if (message) {
        va_list args;
        va_start(args, message);
        NSString *string = [[NSString alloc] initWithFormat:message arguments:args];
        va_end(args);
        if ([invocation.target respondsToSelector:@selector(willLogInvocation:andMessage:)]) {
            string = [invocation.target willLogInvocation:invocation andMessage:string];
        }
        if (string) NSLog(@"%@", string);
    }
}

@end
