#import "RootViewController.h"
#import "MoodViewController.h"
#import "RegisterMoodCommand.h"

@implementation RootViewController

- (void)loadView {
  [super loadView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  MoodViewController *moodViewController = [[MoodViewController alloc] init];
  moodViewController.delegate = self;
  [self presentViewController:moodViewController animated:YES completion:nil];
}

- (void)sendCommand:(MoodCommand *)command {
  __strong id<MoodServiceProtocol> strongDelegate = self.delegate;
  [strongDelegate sendCommand:command];
}

@end