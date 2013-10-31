#import "Kiwi.h"
#import "Nocilla.h"
#import "MoodCommand.h"

SPEC_BEGIN(MoodCommandSpec)

describe(@"Mood service network tests", ^{

  __block MoodCommand *command = nil;

  describe(@"HTTP Status code handling", ^{
    __block id delegateMock = nil;
    
    beforeEach(^{
      delegateMock = [KWMock mockForProtocol:@protocol(CommandDelegate)];
      command = [[MoodCommand alloc] init];
      command.delegate = delegateMock;
    });
    
    it(@"should call success on command delegate for 200 range response", ^{
      NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:[NSURL URLWithString:@"abc"] statusCode:200 HTTPVersion:@"" headerFields:nil];
      [[delegateMock should] receive:@selector(success:)];

      [command processResult:response data:[NSData new] error:nil];
    });

    it(@"should call failure on command delegate for 500 range response", ^{
      NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:[NSURL URLWithString:@"abc"] statusCode:400 HTTPVersion:@"" headerFields:nil];
      [[delegateMock should] receive:@selector(failure:error:)];

      [command processResult:response data:[NSData new] error:nil];
    });

    it(@"should call failure on command delegate for network error and pass through details", ^{
      NSError *error = [NSError errorWithDomain:@"com.dius.moodios" code:123 userInfo:@{NSLocalizedDescriptionKey:@"Failing, failing... 1, 2, 3..."}];
      [[delegateMock should] receive:@selector(failure:error:) withArguments:any(), error];

      [command processResult:nil data:[NSData new] error:error];
    });
  });
  
  describe(@"URL processing", ^{
    beforeEach(^{
      command = [[MoodCommand alloc] initWithMethod:@"GET" contextPath:@"path"];
    });
    
    it(@"should construct url from base", ^{
      NSURLRequest *request = [command urlRequestFromBaseUrl:[NSURL URLWithString:@"http://somewhere.com:1234"]];
      [[request.URL should] equal:[NSURL URLWithString:@"http://somewhere.com:1234/path"]];
    });
    
  });
});

SPEC_END
