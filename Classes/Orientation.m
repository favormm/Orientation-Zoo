#import "Orientation.h"

NSString *NSStringFromUIOrientation(UIInterfaceOrientation io)
{
    static NSString *names[] = {@"unknown", @"portrait", @"portrait u/d",
        @"landscape left", @"landscape right", @"face up", @"face down"};
    assert(io <= 6);
    return names[io];
}

CGAffineTransform CGAffineTransformFromUIOrientation(UIInterfaceOrientation io)
{
    assert(io <= 4);
    // unknown, portrait, portrait u/d, landscape L, landscape R
    static float angles[] = {0, 0, M_PI, M_PI/2, -M_PI/2};
    return CGAffineTransformMakeRotation(angles[io]);
}