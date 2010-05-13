#import "NotifyLog.h"
#import "Orientation.h"

@implementation NotifyLog

- (id) init
{
    [super init];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(orientationChanged:)
        name:UIDeviceOrientationDidChangeNotification
        object:nil];
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [super dealloc];
}

- (void) orientationChanged: (id) notification
{
    UIInterfaceOrientation newIO = [[UIDevice currentDevice] orientation];
    NSLog(@"UIDevice notification, new io: %i [%@]",
        newIO, [Orientation toString:newIO]);
}

@end
