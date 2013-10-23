#import "MoodServiceProtocol.h"

@class RegisterMoodCommand;

@interface MoodService : UIResponder<MoodServiceProtocol>

- (id)initWithBaseUrl:(NSURL *)url;

@end