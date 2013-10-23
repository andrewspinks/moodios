
@protocol CommandDelegate <NSObject>

- (void)success:(id) data;
- (void)failure:(id) data error:(NSError*) error;

@end