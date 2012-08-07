#import "AppMain.h"

@implementation AppMain

- (void) applicationDidFinishLaunching:(NSNotification *)note {
    batteryLog = [[BatteryLog alloc] init];
    notificationPoller = [[NotificationPoller alloc] initWithLog:batteryLog];
}

@end
