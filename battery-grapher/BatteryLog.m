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
        source =    [coder decodeObjectForKey:@"source"];
        event =     [coder decodeObjectForKey:@"event"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[self timestamp] forKey:@"timestamp"];
    [coder encodeInt:   [self charge]    forKey:@"charge"];
    [coder encodeObject:[self source]    forKey:@"source"];
    [coder encodeObject:[self event]     forKey:@"event"];
}

- (Datapoint*) initWithEvent:(EventType*)theEvent {
    return [self initWithEvent:theEvent withTimestamp:nil];
}

- (Datapoint*) initWithEvent:(EventType*)theEvent withTimestamp:(NSDate*)theTimestamp {
    if (self = [super init]) {
//        timestamp = theTimestamp != nil ?
  //      [theTimestamp descriptionWithLocale:[NSLocale currentLocale]] : [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]] ;
        timestamp = theTimestamp != nil ? theTimestamp : [NSDate date];
        charge = 0;
        source = 0;
        
        CFTypeRef sourceInfo = IOPSCopyPowerSourcesInfo();
        CFArrayRef sourceList = IOPSCopyPowerSourcesList(sourceInfo);
        NSDictionary *batteryInfo = (__bridge NSDictionary*)
        //      Is zero necessarily always the battery?
        IOPSGetPowerSourceDescription(sourceInfo, CFArrayGetValueAtIndex(sourceList, 0));
        
        source = [[batteryInfo valueForKey: @"Power Source State"] caseInsensitiveCompare: [NSString stringWithUTF8String:"AC Power"]] ? PowerSource.AC_POWER : PowerSource.BATTERY;
        charge = [batteryInfo valueForKey: @"Current Capacity"];
        
        DebugLog(@"%@ %@ %@ %@", timestamp, source, charge, theEvent);
        event = theEvent;
    }
    return self;
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
    [dataArray addObject:[[Datapoint alloc] initWithEvent:EventType.STARTUP withTimestamp:bootTime]];
}

- (void) appendEntryWithEvent:(EventType*)event {
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
