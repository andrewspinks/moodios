
#import "MoodViewController.h"
#import "RegisterMoodCommand.h"
#import "CommandDelegate.h"


@interface MoodViewController () <CommandDelegate>
@end

@implementation MoodViewController

- (id)init {
  self = [super initWithNibName:@"MoodView" bundle:[NSBundle mainBundle]];
  if (self) {

  }
  return self;
}

- (void)success:(id)data {
  NSLog(@"mood success %@", data);
}

- (void)failure:(id)data error:(NSError *)error {
  NSLog(@"mood failed %@ %@", data, error);
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