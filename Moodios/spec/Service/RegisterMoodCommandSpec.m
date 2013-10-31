#import "Kiwi.h"
#import "Nocilla.h"
#import "RegisterMoodCommand.h"

SPEC_BEGIN(RegisterMoodCommandSpec)

describe(@"Mood command spec", ^{

  describe(@"HTTP Status code handling", ^{
    __block RegisterMoodCommand *subject = nil;
    beforeEach(^{
      subject = [[RegisterMoodCommand alloc] initWithMood:@(10) delegate:nil];
    });

    it(@"should be a POST method", ^{
      [[subject.method should] equal:@"POST"];
    });

    it(@"should construct body", ^{
      [[subject.payload should] equal:@{@"mood": @(10)}];
    });
  });
});

SPEC_END
