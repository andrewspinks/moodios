#import <Foundation/Foundation.h>

#import "CommandDelegate.h"


@interface MoodCommand : NSObject

@property (nonatomic, strong, readonly) NSString *contextPath;
@property (nonatomic, strong, readonly) NSDictionary *payload;
@property (nonatomic, strong, readonly) NSString *method;
@property (nonatomic, weak) id<CommandDelegate> delegate;

- (id)initWithMethod:(NSString *)method contextPath:(NSString *)contextPath payload:(NSDictionary *)payload;
- (NSURLRequest *)urlRequestFromBaseUrl:(NSURL *)url;
- (NSData *)body;

@end