@class MoodService;
@protocol CommandDelegate;

@interface RegisterMoodCommand : NSObject

@property (nonatomic, strong) NSNumber *mood;
@property (nonatomic, weak) id<CommandDelegate> delegate;

- (void)send;

- (NSURLRequest *)urlRequestFromBaseUrl:(NSURL *)url;

- (NSData *)payload;
@end