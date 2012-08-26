#import "BatteryLog.h"

const NSInteger BLUnknownCharge = -1;

@implementation Datapoint

@synthesize timestamp;
@synthesize charge;
@synthesize source;
@synthesize event;

- (Datapoint*) initWithCoder:(NSCoder*)coder {
    if (self = [super init]) {
        timestamp = [coder decodeObjectForKey:@"timestamp"];
        charge =    [coder decodeIntegerForKey:@"charge"];
        source =    [coder decodeObjectForKey:@"source"];
        event =     [coder decodeObjectForKey:@"event"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject: [self timestamp] forKey:@"timestamp"];
    [coder encodeInteger:[self charge]    forKey:@"charge"];
    [coder encodeObject: [self source]    forKey:@"source"];
    [coder encodeObject: [self event]     forKey:@"event"];
}

- (Datapoint*) initWithEvent:(EventType*)theEvent {
    return [self initWithEvent:theEvent withTimestamp:nil];
}

- (Datapoint*) initWithEvent:(EventType*)theEvent withTimestamp:(NSDate*)theTimestamp {
    if (self = [super init]) {
        timestamp = theTimestamp != nil ? theTimestamp : [NSDate date];
        charge = 0;
        source = 0;
        
        CFTypeRef sourceInfo = IOPSCopyPowerSourcesInfo();
        CFArrayRef sourceList = IOPSCopyPowerSourcesList(sourceInfo);
        NSDictionary *batteryInfo = (__bridge NSDictionary*)
            // Is zero necessarily always the battery?
            IOPSGetPowerSourceDescription(sourceInfo, CFArrayGetValueAtIndex(sourceList, 0));        
        
        source = [[batteryInfo valueForKey: @"Power Source State"] isEqual:@"AC Power"] ? PowerSource.AC_POWER : PowerSource.BATTERY;
        charge = theEvent == EventType.STARTUP ? BLUnknownCharge : [[batteryInfo valueForKey: @"Current Capacity"] integerValue];
        event = theEvent;
    }
    return self;
}

- (NSString*) description {
    return charge == BLUnknownCharge ?
    [NSString stringWithFormat:@"  ?%% on %@ t=%.0lf [%@]", source, [timestamp timeIntervalSince1970], event] :
    [NSString stringWithFormat:@"%3ld%% on %@ t=%.0lf [%@]", charge, source, [timestamp timeIntervalSince1970], event];
}

- (NSComparisonResult) compare:(Datapoint*)other {
    return [timestamp compare:[other timestamp]];
}

@end



@interface BatteryLog ()
@property NSMutableArray *dataArray;
@end

@implementation BatteryLog

@synthesize dataArray;

- (BatteryLog*) init {
    self = [super init];
    dataArray = [[NSMutableArray alloc] init];
    return self;
}

- (NSArray*) data {
    return dataArray;
}

- (void) appendBootTimeEntry:(NSDate*)bootTime; {
    // Ignore current battery life and shit when this is rendered in the UI
    [dataArray addObject:[[Datapoint alloc] initWithEvent:EventType.STARTUP withTimestamp:bootTime]];
    DebugLog(@"Logged %@", [dataArray lastObject]);
}

- (void) appendEntryWithEvent:(EventType*)event {
    [dataArray addObject:[[Datapoint alloc] initWithEvent:event]];
    DebugLog(@"Logged %@", [dataArray lastObject]);
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

- (NSArray*) dataFromTime:(NSDate*)start {
    
}

- (NSArray*) dataFromTime:(NSDate*)start toTime:(NSDate*)end {
    
}

- (NSArray*) dataFromTime:(NSDate*)start withDuration:(NSTimeInterval)duration {
    
}

@end
