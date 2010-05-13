@class Controller;

@interface Application : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    Controller *root;
}

@property(retain) IBOutlet UIWindow *window;

@end

