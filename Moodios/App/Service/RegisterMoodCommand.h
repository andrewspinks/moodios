#import "MoodCommand.h"
#import "CommandDelegate.h"
@class MoodService;

@interface RegisterMoodCommand : MoodCommand

- (id)initWithMood:(NSNumber *)mood delegate:(id <CommandDelegate>)delegate;
@end