@class MoodService;

@interface RegisterMoodCommand : NSObject

@property (nonatomic, strong) NSNumber *mood;
@property (nonatomic, weak) id delegate;

- (void)send;
@end