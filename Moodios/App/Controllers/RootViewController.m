#import "RootViewController.h"
#import "MoodViewController.h"
#import "RegisterMoodCommand.h"
#import "MoodTableViewController.h"

@interface RootViewController()
@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation RootViewController

- (void)loadView {
  [super loadView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  MoodTableViewController *moodViewController = [[MoodTableViewController alloc] init];
  self.navController = [[UINavigationController alloc] initWithRootViewController:moodViewController];

  UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Record" style:UIBarButtonItemStylePlain target:self action:@selector(recordMood:)];
  moodViewController.navigationItem.rightBarButtonItem = anotherButton;
  moodViewController.delegate = self;
  [self presentViewController:self.navController animated:YES completion:nil];
}

- (void)recordMood:(id)recordMood {
  MoodViewController *recordMoodController = [[MoodViewController alloc] init];
  recordMoodController.delegate = self;
  [self.navController pushViewController:recordMoodController animated:YES];
}

- (void)sendCommand:(MoodCommand *)command {
  __strong id<MoodServiceProtocol> strongDelegate = self.delegate;
  [strongDelegate sendCommand:command];
}

- (void)flipBack:(id)sender
{
  [self.navController popViewControllerAnimated:YES];
}

@end