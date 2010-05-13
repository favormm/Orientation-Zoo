@interface Orientation : NSObject {}

+ (NSString*) toString: (UIInterfaceOrientation) io;
+ (CGAffineTransform) toTransform: (UIInterfaceOrientation) io;

@end
