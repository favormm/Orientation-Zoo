#import "Orientation.h"

@implementation Orientation
 
+ (NSString*) toString: (UIInterfaceOrientation) io
{
    NSArray *names = [NSArray arrayWithObjects:@"unknown",
        @"portrait", @"portrait u/d", @"landscape left",
        @"landscape right", @"face up", @"face down", nil];
    NSParameterAssert(io < [names count]);
    return [names objectAtIndex:io];
}

+ (CGAffineTransform) toTransform: (UIInterfaceOrientation) io
{
    NSParameterAssert(io <= 4);
    // unknown, portrait, portrait u/d, landscape L, landscape R
    float angles[] = {0, 0, M_PI, M_PI/2, -M_PI/2};
    return CGAffineTransformMakeRotation(angles[io]);
}

@end
