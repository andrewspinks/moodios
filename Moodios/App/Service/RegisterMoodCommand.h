#import "MoodCommand.h"

@class MoodService;
@protocol CommandDelegate;

@interface RegisterMoodCommand : MoodCommand

@property (nonatomic, strong) NSNumber *mood;

@end