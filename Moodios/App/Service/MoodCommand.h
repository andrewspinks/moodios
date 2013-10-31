#import <Foundation/Foundation.h>

#import "CommandDelegate.h"


@interface MoodCommand : NSObject

@property (nonatomic, strong, readonly) NSString *contextPath;
@property (nonatomic, strong, readonly) NSString *method;
@property (nonatomic, weak) id<CommandDelegate> delegate;

- (id)initWithMethod:(NSString *)method contextPath:(NSString *)contextPath;
- (NSURLRequest *)urlRequestFromBaseUrl:(NSURL *)url;

- (NSURLSessionDataTask *)taskForSession:(NSURLSession *)session baseUrl:(NSURL *)baseUrl;

- (void)processResult:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error;
@end