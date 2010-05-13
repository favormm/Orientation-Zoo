#import "Controller.h"
#import "Orientation.h"
#import "View.h"

static int idCounter = 0;

@implementation Controller

- (id) init
{
    [super init];
    idNumber = idCounter++;
    additionalViews = [[NSMutableArray alloc] init];
    return self;
}

- (void) dealloc
{
    [additionalViews release];
    [super dealloc];
}

- (void) loadView
{
    [self setView:[View withController:self]];
}

- (void) viewWillAppear: (BOOL) animated
{
    NSLog(@"[controller #%i viewWillAppear:%i]", idNumber, !!animated);
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear: (BOOL) animated
{
    NSLog(@"[controller #%i viewWillDisappear:%i]", idNumber, !!animated);
    [super viewWillDisappear:animated];
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

- (void) addAnotherController
{
    Controller *modal = [[Controller alloc] init];
    NSLog(@"[controller #%i addAnotherController]", idNumber);
    [self presentModalViewController:modal animated:YES];
    [modal release];
}

- (void) displayActionPopupFrom: (id) sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Actions"
        delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
        otherButtonTitles:@"Add Another View", @"Reset to Single View", 
        @"Present Modal Controller", @"Dismiss Modal Controller", nil];
    [sheet showFromRect:[sender frame] inView:[sender superview] animated:YES];
    [sheet release];
}

- (void) actionSheet: (UIActionSheet*) actionSheet didDismissWithButtonIndex: (NSInteger) button
{
    switch (button) {
        case 0:
            [self.view addSubview:[View withController:self]];
            [additionalViews addObject:[self.view.subviews lastObject]];
            break;
        case 1:
            for (UIView *view in additionalViews)
                [view removeFromSuperview];
            break;
        case 2:
            [self addAnotherController];
            break;
        case 3:
            NSLog(@"[controller #%i dismissModalController]", idNumber);
            [self dismissModalViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

@end
