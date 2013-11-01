
#import <UIKit/UIKit.h>

@protocol MoodServiceProtocol;

@interface MoodListTableViewController : UITableViewController
@property (nonatomic, weak) id<MoodServiceProtocol> delegate;
@end
