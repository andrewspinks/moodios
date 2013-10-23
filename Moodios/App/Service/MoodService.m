
#import "MoodService.h"
#import "RegisterMoodCommand.h"

@interface MoodService()
@property (nonatomic, strong) NSURL *baseUrl;
@end

@implementation MoodService

- (id)initWithBaseUrl:(NSURL *)url {
  if (self = [super init]) {
    self.baseUrl = url;
  }
  return self;
}

- (void)sendCommand:(RegisterMoodCommand *)command {
  NSLog(@"command sent");
}

@end