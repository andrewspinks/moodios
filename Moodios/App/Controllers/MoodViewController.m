
#import "MoodViewController.h"
#import "RegisterMoodCommand.h"


@implementation MoodViewController

- (id)init {
  self = [super initWithNibName:@"MoodView" bundle:[NSBundle mainBundle]];
  if (self) {

  }
  return self;
}

- (IBAction)submitMood {
  RegisterMoodCommand *command = [[RegisterMoodCommand
          alloc] init];
  command.delegate = self;
  command.mood = [NSNumber numberWithFloat:self.slider.value];
  __strong id<MoodServiceProtocol> strongDelegate = self.delegate;
  [strongDelegate sendCommand:command];
}

@end