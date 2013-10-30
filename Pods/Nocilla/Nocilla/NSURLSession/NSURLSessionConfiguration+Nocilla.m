#import "NSURLSessionConfiguration+Nocilla.h"
#import "LSHTTPStubURLProtocol.h"

@implementation NSURLSessionConfiguration (Nocilla)

+ (NSURLSessionConfiguration *)nocilla_defaultSessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration nocilla_defaultSessionConfiguration];
    configuration.protocolClasses=@[[LSHTTPStubURLProtocol class]];
    return configuration;
}

@end