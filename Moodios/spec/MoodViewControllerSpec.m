#import "Kiwi.h"
#import "MoodViewController.h"

SPEC_BEGIN(MoodViewControllerSpec)

describe(@"Mood view controller spec", ^{

  describe(@"Sending commands", ^{
    __block id delegateMock = nil;
    __block MoodViewController *viewController = nil;
    __block id activityIndicator = nil;

    beforeEach(^{
      viewController = [[MoodViewController alloc] init];
      activityIndicator = [KWMock mockForClass:[UIActivityIndicatorView class]];
      viewController.activityIndicator = activityIndicator;
      delegateMock = [KWMock mockForProtocol:@protocol(MoodServiceProtocol)];
      viewController.delegate = delegateMock;
    });

    it(@"should send command on button click", ^{
      [[delegateMock should] receive:@selector(sendCommand:)];
      [[activityIndicator should] receive:@selector(startAnimating)];
      [viewController submitMood];
    });
  });


});

SPEC_END
