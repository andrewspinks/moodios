#import "MoodServiceProtocol.h"

@class MoodCommand;

@interface MoodService : UIResponder<MoodServiceProtocol>

- (id)initWithBaseUrl:(NSURL *)url;

@end