#import "MoodServiceProtocol.h"

@interface MoodViewController : UIViewController

@property (nonatomic, weak) id<MoodServiceProtocol> delegate;
@property (nonatomic, strong) UISlider IBOutlet *slider;
@property (nonatomic, strong) UIActivityIndicatorView IBOutlet *activityIndicator;

- (IBAction)submitMood;

@end