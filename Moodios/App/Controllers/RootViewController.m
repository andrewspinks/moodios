#import "RootViewController.h"
#import "MoodViewController.h"

@implementation RootViewController

- (void)loadView {
  [super loadView];
}


- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  MoodViewController *profileViewController = [[MoodViewController alloc] init];
  [self presentViewController:profileViewController animated:YES completion:nil];
}

@end