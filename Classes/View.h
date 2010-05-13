@interface View : UIView
{
    int idNumber;
    UILabel *frameLabel;
    UILabel *transformLabel;
    UILabel *boundsLabel;
}

+ (id) aView;
- (void) updateInfo;

@end
