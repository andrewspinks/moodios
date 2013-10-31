#import "RegisterMoodCommand.h"
#import "MoodCommand.h"
#import "CommandDelegate.h"


@interface MoodCommand()
@property (nonatomic, strong) NSString *contextPath;
@property (nonatomic, strong) NSDictionary *payload;
@property (nonatomic, strong) NSString *method;
@end

@implementation MoodCommand

- (id)initWithMethod:(NSString *)method contextPath:(NSString *)contextPath payload:(NSDictionary *)payload {
  if (self = [super init]) {
    self.method = method;
    self.contextPath = contextPath;
    self.payload = payload;
  }
  return self;
}

- (NSURLRequest *)urlRequestFromBaseUrl:(NSURL *)url {
  NSURL *moodURL = [url URLByAppendingPathComponent:self.contextPath];
  NSMutableURLRequest *request  = [[NSMutableURLRequest alloc] initWithURL:moodURL];
  [request setHTTPMethod:self.method];
  return request;
}

- (NSData *)body {
  NSError *error;
  if(self.payload) {
    return [NSJSONSerialization dataWithJSONObject:self.payload options:NSJSONWritingPrettyPrinted error:&error];
  } else {
    return nil;
  }
}

@end