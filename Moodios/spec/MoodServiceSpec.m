#import "Kiwi.h"
#import "Nocilla.h"
#import "MoodService.h"
#import "MoodCommand.h"
#import "CommandDelegate.h"

SPEC_BEGIN(MoodServiceSpec)

describe(@"Mood service network tests", ^{
  beforeAll(^{
    [[LSNocilla sharedInstance] start];
  });
  afterAll(^{
    [[LSNocilla sharedInstance] stop];
  });
  afterEach(^{
    [[LSNocilla sharedInstance] clearStubs];
  });

  describe(@"HTTP Status code handling", ^{
    it(@"should call success on command delegate for 200 range response", ^{
      MoodService *moodService = [[MoodService alloc] initWithBaseUrl:[NSURL URLWithString:@"http://somewhere.com"]];

      id delegateMock = [KWMock mockForProtocol:@protocol(CommandDelegate)];
      __block BOOL received = NO;
      [delegateMock stub:@selector(success:) withBlock:^id(NSArray *params) {
        received = YES;
        return nil;
      }];

      MoodCommand *command = [[MoodCommand alloc] initWithMethod:@"GET" contextPath:@"/mood" payload:@{}];
      command.delegate = delegateMock;

      stubRequest(@"GET", @"http://somewhere.com/mood").
              andReturn(201).
              withHeaders(@{ @"Content-Type": @"application/json" });

      [moodService sendCommand:command];

      [[expectFutureValue(theValue(received)) shouldEventually] beYes];
    });
  });

//  describe(@"Network error handling", ^{
//    it(@"should call success on command delegate for 200 range response", ^{
//      NSString *string = @"blah";
//
//      [[string should] equal:@"blah"];
//    });
//  });
});

SPEC_END
