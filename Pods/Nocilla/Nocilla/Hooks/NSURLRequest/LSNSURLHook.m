#import "LSNSURLHook.h"
#import "LSHTTPStubURLProtocol.h"
#import "JRSwizzle.h"

@implementation LSNSURLHook

- (void)load {
    [NSURLProtocol registerClass:[LSHTTPStubURLProtocol class]];
    NSError *error;
    [NSURLSessionConfiguration jr_swizzleClassMethod:@selector(defaultSessionConfiguration) withClassMethod:@selector(nocilla_defaultSessionConfiguration) error:&error];
}

- (void)unload {
    [NSURLProtocol unregisterClass:[LSHTTPStubURLProtocol class]];
    NSError *error;
    [NSURLSessionConfiguration jr_swizzleClassMethod:@selector(nocilla_defaultSessionConfiguration) withClassMethod:@selector(defaultSessionConfiguration) error:&error];
}

@end
