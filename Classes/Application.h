@class Controller, NotifyLog;

@interface Application : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    Controller *root;
    NotifyLog *logger;
}

@property(retain) IBOutlet UIWindow *window;

@end

