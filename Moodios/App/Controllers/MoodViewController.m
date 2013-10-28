
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
  [self.activityIndicator stopAnimating];
}

- (void)failure:(id)data error:(NSError *)error {
  NSLog(@"mood failed: %@", error);
  [self.activityIndicator stopAnimating];
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alertView show];
}

- (IBAction)submitMood {
  __strong id<MoodServiceProtocol> strongDelegate = self.delegate;

  [self.activityIndicator startAnimating];
  [strongDelegate sendCommand:[self constructSubmitCommand]];
}

- (RegisterMoodCommand *)constructSubmitCommand {
  RegisterMoodCommand *command = [[RegisterMoodCommand
          alloc] init];
  command.delegate = self;
  command.mood = [NSNumber numberWithFloat:self.slider.value];
  return command;
}

@end