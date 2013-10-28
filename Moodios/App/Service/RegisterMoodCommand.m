#import "RegisterMoodCommand.h"
#import "MoodService.h"
#import "CommandDelegate.h"

@implementation RegisterMoodCommand

- (NSURLRequest *)urlRequestFromBaseUrl:(NSURL *)url {
  NSURL *moodURL = [url URLByAppendingPathComponent:@"moods/new"];
  NSMutableURLRequest *request  = [[NSMutableURLRequest alloc] initWithURL:moodURL];
  [request setHTTPMethod:@"POST"];
  return request;
}

- (NSData *)payload {
  NSDictionary *payload = @{ @"mood" : self.mood.stringValue };
  NSError *error;
  return [NSJSONSerialization dataWithJSONObject:payload options:NSJSONWritingPrettyPrinted error:&error];
}
@end