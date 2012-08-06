#import <Cocoa/Cocoa.h>
#import "BatteryPoller.h"
#import "BatteryLog.h"

@interface AppMain: NSObject <NSApplicationDelegate> {
    BatteryPoller *batteryPoller;
    BatteryLog *batteryLog;
}

@end
