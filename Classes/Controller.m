#import "Controller.h"
#import "Orientation.h"
#import "View.h"

static int idCounter = 0;

@implementation Controller

- (id) init
{
    [super init];
    idNumber = idCounter++;
    return self;
}

- (void) loadView
{
    [self setView:[View aView]];
}

- (void) viewWillAppear: (BOOL) animated
{
    NSLog(@"[controller #%i viewWillAppear:%i]", idNumber, !!animated);
    [super viewWillAppear:animated];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) io
{
    NSLog(@"[controller #%i shouldAutorotateTo:%i (== %@)]",
        idNumber, io, [Orientation toString:io]);
    return YES;
}

- (void) didRotateFromInterfaceOrientation: (UIInterfaceOrientation) io
{
    [(id) self.view updateInfo];
}

@end
