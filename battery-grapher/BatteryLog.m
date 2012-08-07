#import "BatteryLog.h"

@implementation Datapoint

@synthesize timestamp;
@synthesize charge;
@synthesize source;
@synthesize event;

- (Datapoint*) initWithCoder:(NSCoder*)coder {
    if (self = [super init]) {
        timestamp = [coder decodeObjectForKey:@"timestamp"];
        charge =    [coder decodeIntForKey:@"charge"];
        source =    [coder decodeIntForKey:@"source"];
        event =     [coder decodeIntForKey:@"event"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[self timestamp] forKey:@"timestamp"];
    [coder encodeInt:   [self charge]    forKey:@"charge"];
    [coder encodeInt:   [self source]    forKey:@"source"];
    [coder encodeInt:   [self event]     forKey:@"event"];
}

- (Datapoint*) initWithEvent:(EventType)theEvent {
    if (self = [super init]) {
        timestamp = [NSDate date];
        charge = 0;
        source = 0;
        
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
        DebugLog(@"%d", theEvent);
        
        event = theEvent;
    }
    return self;
}

@end

@interface BatteryLog ()
@property NSMutableArray *dataArray;
@end

@implementation BatteryLog

@synthesize dataArray;

- (NSArray*) data {
    return dataArray;
}

- (void) appendEntryWithEvent:(EventType)event {
    [dataArray addObject:[[Datapoint alloc] initWithEvent:event]];
}

- (BatteryLog*) initWithFile:(NSString*)filename {
    if (self = [super init]) {
        dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    }
    NSLog(@"Loaded history for %ld events from %@.", [dataArray count], filename);
    return self;
}

- (void) saveToFile:(NSString*)filename {
    [NSKeyedArchiver archiveRootObject:dataArray toFile:filename];
    NSLog(@"Saved history for %ld events to %@.", [dataArray count], filename);
}

@end
