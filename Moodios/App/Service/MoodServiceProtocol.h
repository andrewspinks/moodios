@class MoodCommand;
@class MoodViewController;

@protocol MoodServiceProtocol <NSObject>

-(void)sendCommand:(MoodCommand *)command;

@end