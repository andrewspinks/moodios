@class MoodService;
@protocol CommandDelegate;

@interface RegisterMoodCommand : NSObject

@property (nonatomic, strong) NSNumber *mood;
@property (nonatomic, weak) id<CommandDelegate> delegate;

- (NSURLRequest *)urlRequestFromBaseUrl:(NSURL *)url;
- (NSData *)payload;
@end