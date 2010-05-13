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

@end
