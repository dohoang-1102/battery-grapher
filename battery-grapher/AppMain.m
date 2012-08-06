#import "AppMain.h"

@implementation AppMain

- (void) applicationDidFinishLaunching:(NSNotification *)note {
    NSTimer *batteryStatusTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(printBatteryStatus) userInfo:nil repeats:YES];
}

- (void) printBatteryStatus {
    CFTypeRef sourceInfo = IOPSCopyPowerSourcesInfo();
    CFArrayRef sourceList = IOPSCopyPowerSourcesList(sourceInfo);
    NSLog(@"%@", IOPSGetPowerSourceDescription(sourceInfo, sourceList));
}

@end
