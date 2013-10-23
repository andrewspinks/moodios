#import "RegisterMoodCommand.h"
#import "MoodService.h"
#import "CommandDelegate.h"

@implementation RegisterMoodCommand

- (void)send {

}

- (NSURLSession *)createSession {
  return nil;
}

- (NSURLRequest *)urlRequestFromBaseUrl:(NSURL *)url {
  NSURL *moodURL = [url URLByAppendingPathComponent:@"moods/new"];
  NSMutableURLRequest *request  = [[NSMutableURLRequest alloc] initWithURL:moodURL];
  [request setHTTPMethod:@"POST"];
  return request;
}

- (NSData *)payload {
  NSDictionary *payload = @{ @"mood" : self.mood.stringValue };

  NSError *error;
  NSData *data = [NSJSONSerialization dataWithJSONObject:payload options:NSJSONWritingPrettyPrinted error:&error];
//  NSData data
  return data;
}
@end