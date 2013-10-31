#import "RegisterMoodCommand.h"
#import "MoodCommand.h"
#import "CommandDelegate.h"


@interface MoodCommand()
@property (nonatomic, strong) NSString *contextPath;
@property (nonatomic, strong) NSString *method;
@end

@implementation MoodCommand

- (id)initWithMethod:(NSString *)method contextPath:(NSString *)contextPath {
  if (self = [super init]) {
    self.method = method;
    self.contextPath = contextPath;
  }
  return self;
}

- (NSURLRequest *)urlRequestFromBaseUrl:(NSURL *)url {
  NSURL *moodURL = [url URLByAppendingPathComponent:self.contextPath];
  NSMutableURLRequest *request  = [[NSMutableURLRequest alloc] initWithURL:moodURL];
  [request setHTTPMethod:self.method];
  return request;
}

- (NSURLSessionDataTask *)taskForSession:(NSURLSession *)session baseUrl:(NSURL *)baseUrl {
  return nil;
}

- (void)processResult:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error {
  __strong id<CommandDelegate> delegate = self.delegate;
  NSError *jsonError;
  id returnedData = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&jsonError];
  NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *) response;
  if (!error && httpResp.statusCode >= 200 && httpResp.statusCode < 400) {
    [delegate success:returnedData];
  } else {
    [delegate failure:returnedData error:error];
  }
}

@end