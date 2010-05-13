#import "Application.h"
#import "Controller.h"

@implementation Application
@synthesize window;

- (void) applicationDidFinishLaunching: (UIApplication*) application
{
    root = [[Controller alloc] init];
    [window addSubview:root.view];
    [window makeKeyAndVisible];
}

- (void)dealloc
{
    [root release];
    [window release];
    [super dealloc];
}

@end
