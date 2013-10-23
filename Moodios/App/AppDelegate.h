
#import <UIKit/UIKit.h>
#import "MoodServiceProtocol.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, MoodServiceProtocol>

@property (nonatomic, weak) id<MoodServiceProtocol> delegate;
@property (strong, nonatomic) UIWindow *window;

@end
