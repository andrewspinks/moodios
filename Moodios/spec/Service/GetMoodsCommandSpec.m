#import "Kiwi.h"
#import "Nocilla.h"
#import "GetMoodsCommand.h"

SPEC_BEGIN(GetMoodsCommandSpec)

describe(@"Mood command spec", ^{

  describe(@"HTTP Status code handling", ^{
    __block GetMoodsCommand *subject = nil;
    beforeEach(^{
      subject = [[GetMoodsCommand alloc] init];
    });

    it(@"should be a GET method", ^{
      [[subject.method should] equal:@"GET"];
    });

    it(@"should be use correct path", ^{
      [[subject.contextPath should] equal:@"moods"];
    });
  });


});

SPEC_END
