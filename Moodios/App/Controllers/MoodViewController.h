#import "MoodServiceProtocol.h"

@interface MoodViewController : UIViewController

@property (nonatomic, weak) id<MoodServiceProtocol> delegate;
@property (nonatomic, strong) UISlider IBOutlet *slider;

- (IBAction)submitMood;

@end