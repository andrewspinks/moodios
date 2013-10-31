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
  NSURLSessionDataTask *task = nil;

  if([command.method isEqualToString:@"GET"]) {
    task = [urlSession dataTaskWithRequest:[command urlRequestFromBaseUrl:self.baseUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      __strong id<CommandDelegate> delegate = command.delegate;
      NSError *jsonError;
      id returnedData = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:&jsonError];
      NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
      if (!error && httpResp.statusCode >= 200 && httpResp.statusCode < 400) {
        [delegate success:returnedData];
      } else {
        [delegate failure:returnedData error:error];
      }
    }];

  } else {
    task = [urlSession uploadTaskWithRequest:[command urlRequestFromBaseUrl:self.baseUrl] fromData:[command body] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      __strong id<CommandDelegate> delegate = command.delegate;
      NSError *jsonError;
      id returnedData = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:&jsonError];
      NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
      if (!error && httpResp.statusCode == 201) {
        [delegate success:returnedData];
      } else {
        [delegate failure:returnedData error:error];
      }
    }];
  }

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