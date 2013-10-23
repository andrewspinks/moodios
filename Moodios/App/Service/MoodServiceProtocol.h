@class RegisterMoodCommand;

@protocol MoodServiceProtocol <NSObject>

-(void)sendCommand:(RegisterMoodCommand *)command;

@end