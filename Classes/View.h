@interface View : UIView
{
    int idNumber;
    UILabel *frameLabel;
    UILabel *transformLabel;
    UILabel *boundsLabel;
}

- (void) updateInfo;

@end
