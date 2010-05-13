#import "View.h"

static NSArray *bgColors = nil;
static int bgColorIndex  = 0;
static int idCounter     = 0;

@interface View ()
- (UILabel*) infoLabel;
- (UILabel*) idLabel;
- (UISlider*) alphaSlider;
- (UIButton*) actionButton;
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
    
    [self addSubview:[self alphaSlider]];
    [self addSubview:[self actionButton]];
    return self;
}

#pragma mark View Components

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

- (UISlider*) alphaSlider
{
    UISlider *slider = [[UISlider alloc] init];
    [slider addTarget:self action:@selector(changeAlphaFrom:)
        forControlEvents:UIControlEventValueChanged];
    [slider setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin
        | UIViewAutoresizingFlexibleTopMargin];
    [slider setValue:1];
    [slider setFrame:CGRectMake(500, 900, 200, 40)];
    return [slider autorelease];
}

- (UIButton*) actionButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [button.titleLabel setText:@"Actions"];
    [button sizeToFit];
    [button setCenter:CGPointMake(50, 1004-50)];
    [button setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin
        | UIViewAutoresizingFlexibleTopMargin];
    [button addTarget:controller action:@selector(displayActionPopupFrom:)
        forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark Updating

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

- (void) setTransform: (CGAffineTransform) newTransform
{
    NSLog(@"[view #%i setTransform:]", idNumber);
    [super setTransform:newTransform];
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
