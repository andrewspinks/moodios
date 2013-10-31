#import "MoodService.h"
#import "RegisterMoodCommand.h"
#import "CommandDelegate.h"

@interface MoodService () <NSURLSessionDelegate>
@property(nonatomic, strong) NSURL *baseUrl;
@end

@implementation MoodService

- (id)initWithBaseUrl:(NSURL *)url {
  if (self = [super init]) {
    self.baseUrl = url;
  }
  return self;
}

- (void)sendCommand:(MoodCommand *)command {
  NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:[self configuration] delegate:self delegateQueue:nil];
  NSURLSessionDataTask *task = [command taskForSession:urlSession baseUrl:self.baseUrl];

  [task resume];
}

- (NSURLSessionConfiguration *)configuration {
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  [configuration setHTTPAdditionalHeaders:
          @{@"Accept" : @"application/json"}];
  [configuration setHTTPAdditionalHeaders:
          @{@"Content-Type" : @"application/json"}];
  return configuration;
}

@end