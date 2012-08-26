#import <Foundation/Foundation.h>
#import "BatteryEnumTypes.h"

#define DEFAULT_LOG_NAME @"batterylog.dat"

extern const NSInteger BLUnknownCharge;

// Not a great name.
@interface Datapoint : NSObject <NSCoding>

@property (readonly) NSDate *timestamp;
@property (readonly) NSInteger charge;
@property (readonly) PowerSource *source;
@property (readonly) EventType *event;

// Comparison based solely on timestamps.
- (NSComparisonResult) compare:(Datapoint*)other;

@end



@interface BatteryLog : NSObject

@property (readonly) NSArray *data;

- (void) appendBootTimeEntry:(NSDate*)bootTime;
- (void) appendEntryWithEvent:(EventType*)theEvent;

- (BatteryLog*) initWithFile:(NSString*)filename;
- (void) saveToFile:(NSString*)filename;

- (NSArray*) dataFromTime:(NSDate*)start;
- (NSArray*) dataFromTime:(NSDate*)start toTime:(NSDate*)end;
- (NSArray*) dataFromTime:(NSDate*)start withDuration:(NSTimeInterval)duration;

@end
