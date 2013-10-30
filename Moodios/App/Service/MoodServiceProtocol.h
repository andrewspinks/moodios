@class MoodCommand;

@protocol MoodServiceProtocol <NSObject>

-(void)sendCommand:(MoodCommand *)command;

@end