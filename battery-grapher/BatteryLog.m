#import "BatteryLog.h"

@interface BatteryLog ()
@property NSMutableArray *dataArray;
@end

@implementation BatteryLog

@synthesize data = dataArray;

- (void) appendEntryWithEvent:(EventType)event {
//    CFTypeRef sourceInfo = IOPSCopyPowerSourcesInfo();
//    CFArrayRef sourceList = IOPSCopyPowerSourcesList(sourceInfo);
//    NSDictionary *batteryInfo = (__bridge NSDictionary*)
//    // Is zero necessarily always the battery?
//        IOPSGetPowerSourceDescription(sourceInfo, CFArrayGetValueAtIndex(sourceList, 0));
//    NSLog(@"%@", batteryInfo);
//    NSNumber *currentCharge = [batteryInfo valueForKey: @"Current Capacity"];
//    NSLog(@"%d", [currentCharge intValue]);
//    
////    NSString *powerSource = [batteryInfo valueForKey: @"Power Source State"];
////    NSString *batteryCapacity = [batteryInfo valueForKey: @"Current Capacity"];
    NSLog(@"%d", event);
}

@end
