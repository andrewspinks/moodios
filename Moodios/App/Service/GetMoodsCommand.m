#import "GetMoodsCommand.h"

@implementation GetMoodsCommand

- (NSString *)method {
  return @"GET";
}

- (NSString *)contextPath {
  return @"moods";
}

- (NSURLSessionDataTask *)taskForSession:(NSURLSession *)session baseUrl:(NSURL *)baseUrl {
  return [session dataTaskWithRequest:[self urlRequestFromBaseUrl:baseUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    [self processResult:response data:data error:error];
  }];
}

@end