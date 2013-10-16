#import "Kiwi.h"

SPEC_BEGIN(MoodiosSpec)

describe(@"SampleSpec", ^{
  it(@"should check something cool goes on", ^{
    NSString *string = @"blah";

    [[string should] equal:@"blah"];
  });
});

SPEC_END
