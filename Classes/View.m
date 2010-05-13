#import "View.h"

static NSArray *bgColors = nil;
static int bgColorIndex  = 0;
static int idCounter     = 0;

@interface View ()
- (UILabel*) infoLabel;
- (UILabel*) idLabel;
@end

@implementation View
@synthesize controller;

#pragma mark Initialization

+ (void) initialize
{
    bgColors = [[NSArray alloc] initWithObjects:
        [UIColor redColor], [UIColor greenColor],
        [UIColor blueColor], nil];
}

- (UIColor*) nextColor
{
    bgColorIndex = (bgColorIndex + 1) % [bgColors count];
    return [bgColors objectAtIndex:bgColorIndex];
}

+ (id) withController: (id) ctrl
{
    return [[[self alloc] initWithController:ctrl] autorelease];
}

- (id) initWithController: (id) ctrl
{
    [super initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    controller = ctrl;

    [self setBackgroundColor:[self nextColor]];
    idNumber = idCounter++;
    [self addSubview:[self idLabel]];
    
    frameLabel = [self infoLabel];
    [frameLabel setCenter:CGPointMake(100, 200)];
    [self addSubview:frameLabel];

    boundsLabel = [self infoLabel];
    [boundsLabel setCenter:CGPointMake(100, 280)];
    [self addSubview:boundsLabel];
    
    transformLabel = [self infoLabel];
    [transformLabel setCenter:CGPointMake(100, 360)];
    [self addSubview:transformLabel];
    
    UISlider *slider = [[[UISlider alloc] init] autorelease];
    [slider addTarget:self action:@selector(changeAlphaFrom:)
        forControlEvents:UIControlEventValueChanged];
    [slider setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin
        | UIViewAutoresizingFlexibleTopMargin];
    [slider setValue:1];
    [slider setFrame:CGRectMake(500, 900, 200, 40)];
    [self addSubview:slider];
    return self;
}

#pragma mark Info Labels

- (UILabel*) infoLabel
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:40]];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor blackColor]];
    return [label autorelease];
}

- (UILabel*) idLabel
{
    UILabel *label = [self infoLabel];
    [label setText:[NSString stringWithFormat:@"View #%i", idNumber]];
    [label setFont:[UIFont systemFontOfSize:60]];
    [label setCenter:CGPointMake(100, 100)];
    [label sizeToFit];
    return label;
}

- (void) updateInfo
{
    BOOL transformIsId = CGAffineTransformIsIdentity(self.transform);
    [frameLabel setText:[NSString stringWithFormat:@"f: %@",
        NSStringFromCGRect(self.frame)]];
    // “If the transform property is not the identity transform, the value
    // of this property is undefined and therefore should be ignored.”
    [frameLabel setTextColor:transformIsId ? [UIColor whiteColor] : [UIColor redColor]];
    [frameLabel sizeToFit];
    [boundsLabel setText:[NSString stringWithFormat:@"b: %@",
        NSStringFromCGRect(self.bounds)]];
    [boundsLabel sizeToFit];
    [transformLabel setText:[NSString stringWithFormat:@"transform is id: %i", transformIsId]];
    [transformLabel sizeToFit];
}

- (void) setFrame: (CGRect) newFrame
{
    NSLog(@"[view #%i setFrame:%@]", idNumber, NSStringFromCGRect(newFrame));
    [super setFrame:newFrame];
    [self updateInfo];
}

- (void) willMoveToSuperview: (UIView*) newSuperview
{
    [self updateInfo];
}

- (void) changeAlphaFrom: (UISlider*) slider
{
    self.alpha = slider.value;
}

@end
