#import "Kiwi.h"
#import "Nocilla.h"
#import "MoodService.h"
#import "MoodCommand.h"
#import "GetMoodsCommand.h"
#import "RegisterMoodCommand.h"

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
    __block id delegateMock = nil;
    __block MoodCommand *command = nil;
    __block MoodService *moodService = nil;

    beforeEach(^{
      moodService = [[MoodService alloc] initWithBaseUrl:[NSURL URLWithString:@"http://somewhere.com"]];
      delegateMock = [KWMock mockForProtocol:@protocol(CommandDelegate)];
      command = [[MoodCommand alloc] initWithMethod:@"GET" contextPath:@"/mood" payload:@{}];
      command.delegate = delegateMock;
    });

    it(@"should call success on command delegate for 200 range response", ^{
      __block BOOL received = NO;
      [delegateMock stub:@selector(success:) withBlock:^id(NSArray *params) {
        received = YES;
        return nil;
      }];

      stubRequest(@"GET", @"http://somewhere.com/mood").
              andReturn(201).
              withHeaders(@{ @"Content-Type": @"application/json" });

      [moodService sendCommand:command];

      [[expectFutureValue(theValue(received)) shouldEventually] beYes];
    });

    it(@"should call failure on command delegate for 500 range response", ^{
      __block BOOL received = NO;
      [delegateMock stub:@selector(failure:error:) withBlock:^id(NSArray *params) {
        received = YES;
        return nil;
      }];

      stubRequest(@"GET", @"http://somewhere.com/mood").
              andReturn(500);

      [moodService sendCommand:command];

      [[expectFutureValue(theValue(received)) shouldEventually] beYes];
    });

    it(@"should call failure on command delegate for network error and pass through details", ^{
      __block BOOL received = NO;
      __block NSError *error = [NSError errorWithDomain:@"com.dius.moodios" code:123 userInfo:@{NSLocalizedDescriptionKey:@"Failing, failing... 1, 2, 3..."}];
      __block NSError *capturedError = nil;

      [delegateMock stub:@selector(failure:error:) withBlock:^id(NSArray *params) {
        received = YES;
        capturedError = params[1];
        return nil;
      }];

      stubRequest(@"GET", @"http://somewhere.com/mood").
              andFailWithError(error);

      [moodService sendCommand:command];

      [[expectFutureValue(theValue(received)) shouldEventually] beYes];
      [[expectFutureValue(theValue(capturedError.code)) shouldEventually] equal:theValue(error.code)];
    });

    it(@"should send GET requests", ^{
      __block BOOL received = NO;

      GetMoodsCommand *getCommand = [[GetMoodsCommand alloc] init];
      [delegateMock stub:@selector(success:) withBlock:^id(NSArray *params) {
        received = YES;
        return nil;
      }];
      getCommand.delegate = delegateMock;

      stubRequest(@"GET", @"http://somewhere.com/moods")
              .withHeaders(@{ @"Content-Type": @"application/json" })
              .andReturn(200)
              .withBody(@"[{\"_id\":\"1\",\"created_at\":\"2013-07-11T02:25:42+00:00\",\"level\":\"Time to go home\"},{\"_id\":\"5\",\"created_at\":\"2013-07-11T02:25:52+00:00\",\"level\":\"1\",\"updated_at\":\"2013-07-11T02:25:52+00:00\"}]");

      [moodService sendCommand:getCommand];

      [[expectFutureValue(theValue(received)) shouldEventually] beYes];
    });

    it(@"should send POST requests", ^{
      __block BOOL received = NO;

      RegisterMoodCommand *postCommand = [[RegisterMoodCommand alloc] initWithMood:@(1.0) delegate:delegateMock];
      [delegateMock stub:@selector(success:) withBlock:^id(NSArray *params) {
        received = YES;
        return nil;
      }];

      stubRequest(@"POST", @"http://somewhere.com/moods/new").
              withHeaders(@{ @"Content-Length": @"18", @"Content-Type": @"application/json" }).
              andReturn(201);

      [moodService sendCommand:postCommand];

      [[expectFutureValue(theValue(received)) shouldEventually] beYes];
    });
  });


});

SPEC_END
