#import "MoodCommand.h"
#import "CommandDelegate.h"
@class MoodService;

@interface RegisterMoodCommand : MoodCommand

@property (nonatomic, retain, readonly) NSDictionary *payload;
- (id)initWithMood:(NSNumber *)mood delegate:(id <CommandDelegate>)delegate;

@end