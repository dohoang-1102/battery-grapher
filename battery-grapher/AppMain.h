#import <Cocoa/Cocoa.h>
#import "BatteryPolling.h"
@interface AppMain: NSObject <NSApplicationDelegate> {
    BatteryPolling * bp;
}


- (void) printBatteryStatus;

@end
