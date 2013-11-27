
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
  [[UIApplication sharedApplication] sendAction:@selector(flipBack:) to:nil from:self forEvent:nil];
}

- (void)failure:(id)data error:(NSError *)error {
  [self.activityIndicator stopAnimating];
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alertView show];
}

- (IBAction)submitMood {
  self.navigationItem.leftBarButtonItem.enabled = NO;
  __strong id<MoodServiceProtocol> strongDelegate = self.delegate;
  [self.activityIndicator startAnimating];
  [strongDelegate sendCommand:[[RegisterMoodCommand alloc] initWithMood:[NSNumber numberWithFloat:self.slider.value] delegate:self]];
}

@end