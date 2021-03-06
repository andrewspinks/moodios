#import "RegisterMoodCommand.h"
#import "MoodService.h"
#import "CommandDelegate.h"

@interface RegisterMoodCommand()
@property (nonatomic, retain) NSDictionary *payload;
@end

@implementation RegisterMoodCommand

- (id)initWithMood:(NSNumber *)mood delegate:(id<CommandDelegate>)delegate {
  if (self = [super initWithMethod:@"POST" contextPath:@"moods/new"]) {
    self.delegate = delegate;
    self.payload = @{ @"mood" : mood };
  }
  return self;
}

- (NSData *)body {
  NSError *error;
  return [NSJSONSerialization dataWithJSONObject:self.payload options:NSJSONWritingPrettyPrinted error:&error];
}

- (NSURLSessionDataTask *)taskForSession:(NSURLSession *)session baseUrl:(NSURL *)baseUrl {
  return [session uploadTaskWithRequest:[self urlRequestFromBaseUrl:baseUrl] fromData:self.body completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    [self processResult:response data:data error:error];
  }];
}
@end