#import "RegisterMoodCommand.h"
#import "MoodService.h"
#import "CommandDelegate.h"

@interface RegisterMoodCommand()
@end

@implementation RegisterMoodCommand

- (id)initWithMood:(NSNumber *)mood delegate:(id<CommandDelegate>)delegate {
  if (self = [super initWithMethod:@"POST" contextPath:@"/moods/new" payload:@{ @"mood" : mood.stringValue }]) {
    self.delegate = delegate;
  }
  return self;
}

@end