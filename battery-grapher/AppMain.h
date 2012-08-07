#import <Cocoa/Cocoa.h>
#import "NotificationPoller.h"
#import "BatteryLog.h"

@interface AppMain: NSObject <NSApplicationDelegate> {
    NotificationPoller *notificationPoller;
    BatteryLog *batteryLog;
}

@end
