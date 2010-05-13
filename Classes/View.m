#import "View.h"

static NSArray *bgColors = nil;
static int bgColorIndex  = 0;
static int idCounter     = 0;

@implementation View

+ (void) initialize
{
    bgColors = [NSArray arrayWithObjects:
        [UIColor redColor], [UIColor greenColor],
        [UIColor blueColor], nil];
}

- (UIColor*) nextColor
{
    bgColorIndex = (bgColorIndex + 1) % [bgColors count];
    return [bgColors objectAtIndex:bgColorIndex];
}

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

- (id) initWithFrame: (CGRect) frame
{
    [super initWithFrame:frame];
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
    
    return self;
}

- (void) updateInfo
{
    [frameLabel setText:[NSString stringWithFormat:@"f: %@",
        NSStringFromCGRect(self.frame)]];
    [frameLabel sizeToFit];
    [boundsLabel setText:[NSString stringWithFormat:@"b: %@",
        NSStringFromCGRect(self.bounds)]];
    [boundsLabel sizeToFit];
    [transformLabel setText:[NSString stringWithFormat:@"transform is id: %i",
        CGAffineTransformIsIdentity(self.transform)]];
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

@end
