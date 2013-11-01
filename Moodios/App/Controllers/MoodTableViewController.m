#import "MoodTableViewController.h"
#import "CommandDelegate.h"
#import "GetMoodsCommand.h"
#import "MoodServiceProtocol.h"

@interface MoodTableViewController () <CommandDelegate>
@property(nonatomic, strong) NSArray *moodList;
@end

@implementation MoodTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.refreshControl = [[UIRefreshControl alloc] init];
  [self.refreshControl addTarget:self action:@selector(requestMoods) forControlEvents:UIControlEventValueChanged];
  [self requestMoods];
}

- (void)requestMoods {
  __strong id<MoodServiceProtocol> strongDelegate = self.delegate;
  GetMoodsCommand *getMoodsCommand = [[GetMoodsCommand alloc] init];
  getMoodsCommand.delegate = self;
  [strongDelegate sendCommand:getMoodsCommand];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return (NSInteger)[self.moodList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
  }

  cell.textLabel.text = @"";
  cell.detailTextLabel.text = @"";
  NSDictionary *mood = self.moodList[(NSUInteger)indexPath.row];
  cell.textLabel.text = mood[@"created_at"];
  id level = mood[@"level"];
  if(level && ([level class] != [NSNull class])) {
    cell.detailTextLabel.text = mood[@"level"];
  }

  return cell;
}


#pragma mark CommandDelegate methods
- (void)success:(id)data {
  NSArray *returnedList = (NSArray *)data;
  self.moodList = returnedList;
  [self.tableView reloadData];
  [self.refreshControl endRefreshing];
}

- (void)failure:(id)data error:(NSError *)error {
  NSLog(@"failure %@ %@", data, error);
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alertView show];
}

@end
