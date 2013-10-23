#import "MoodServiceProtocol.h"

@interface RootViewController : UIViewController<MoodServiceProtocol>

@property (nonatomic, weak) id<MoodServiceProtocol> delegate;

@end