#import "AppMain.h"
#import "BatteryPolling.h"

@implementation AppMain

- (void) applicationDidFinishLaunching:(NSNotification *)note {
    [[BatteryPolling alloc] init];
    

    
    
    NSTimer *batteryStatusTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(printBatteryStatus) userInfo:nil repeats:YES];
}
- (void) notificationCallback:(NSNotification *)notification {
    NSLog(@"%@", [notification name]);
}

- (void) printBatteryStatus {
    CFTypeRef sourceInfo = IOPSCopyPowerSourcesInfo();
    CFArrayRef sourceList = IOPSCopyPowerSourcesList(sourceInfo);
    NSDictionary *battery_info = (__bridge NSDictionary*) IOPSGetPowerSourceDescription(sourceInfo, CFArrayGetValueAtIndex(sourceList, 0));
    NSString *power_source =[battery_info valueForKey: @"Power Source State"];
    NSString *battery_capacity = [battery_info valueForKey: @"Current Capacity"];
   // NSLog(@"%@ : %@%% remaining", power_source, battery_capacity);
   
    
    
    
//    NSLog(@"%@", IOPSGetPowerSourceDescription(sourceInfo, CFArrayGetValueAtIndex(sourceList, 0)));
}

@end
