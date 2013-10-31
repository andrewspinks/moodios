#import "GetMoodsCommand.h"

@implementation GetMoodsCommand

- (NSString *)method {
  return @"GET";
}

- (NSString *)contextPath {
  return @"/moods";
}

@end