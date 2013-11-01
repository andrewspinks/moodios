
#import <UIKit/UIKit.h>

@protocol MoodServiceProtocol;

@interface MoodTableViewController : UITableViewController
@property (nonatomic, weak) id<MoodServiceProtocol> delegate;
@end
