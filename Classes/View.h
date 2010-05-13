@interface View : UIView
{
    id controller;
    int idNumber;
    UILabel *frameLabel;
    UILabel *transformLabel;
    UILabel *boundsLabel;
}

@property(readonly) id controller;

+ (id) withController: (id) ctrl;
- (id) initWithController: (id) ctrl;

- (void) updateInfo;

@end
