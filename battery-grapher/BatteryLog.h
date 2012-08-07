#import <Foundation/Foundation.h>
#import "BatteryEnumTypes.h"

#define DEFAULT_LOG_NAME @"batterylog.dat"

// Not a great name.
@interface Datapoint : NSObject <NSCoding>

@property (readonly) NSDate *timestamp;
@property (readonly) int charge;
@property (readonly) PowerSource *source;
@property (readonly) EventType *event;

@end

@interface BatteryLog : NSObject

@property (readonly) NSArray *data;

- (void) appendBootTimeEntry:(NSDate*)boottime;
- (void) appendEntryWithEvent:(EventType*)theEvent;

- (BatteryLog*) initWithFile:(NSString*)filename;
- (void) saveToFile:(NSString*)filename;

@end
