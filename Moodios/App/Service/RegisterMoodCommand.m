#import "RegisterMoodCommand.h"
#import "MoodService.h"
#import "CommandDelegate.h"

@implementation RegisterMoodCommand

- (NSString *)contextPath {
  return @"/moods/new";
}

- (NSString *)methods {
  return @"POST";
}

- (NSDictionary *)payload {
  return @{ @"mood" : self.mood.stringValue };
}

@end