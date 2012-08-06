#import "AppMain.h"

@implementation AppMain

- (void) applicationDidFinishLaunching:(NSNotification *)note {
    batteryLog = [[BatteryLog alloc] init];
    batteryPoller = [[BatteryPoller alloc] initWithLog:batteryLog];
}

@end
