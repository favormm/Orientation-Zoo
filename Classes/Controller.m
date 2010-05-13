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
    NSLog(@"[controller #%i dealloc]", idNumber);
    [additionalViews release];
    [super dealloc];
}

- (void) loadView
{
    [self setView:[View withController:self]];
}

#pragma mark Callbacks and Notifications

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

#pragma mark Additional Controllers

- (void) addAnotherController
{
    Controller *modal = [[Controller alloc] init];
    NSLog(@"[controller #%i addAnotherController]", idNumber);
    [self presentModalViewController:modal animated:YES];
    [modal release];
}

- (void) attachAnotherControllerByHand
{
    Controller *new = [[Controller alloc] init];
    NSLog(@"[controller #%i attachAnotherControllerByHand]", idNumber);
    [self.view.window addSubview:new.view];
    // intentionally leaking here
}

#pragma mark Controls

- (void) displayActionPopupFrom: (id) sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Actions"
        delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
        otherButtonTitles:@"Add Another View", @"Reset to Single View", 
        @"Present Modal Controller", @"Dismiss Modal Controller",
        @"Attach Controller by Hand", nil];
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
            [additionalViews removeAllObjects];
            break;
        case 2:
            [self addAnotherController];
            break;
        case 3:
            NSLog(@"[controller #%i dismissModalController]", idNumber);
            [self dismissModalViewControllerAnimated:YES];
            break;
        case 4:
            [self attachAnotherControllerByHand];
            break;
        default:
            break;
    }
}

@end
