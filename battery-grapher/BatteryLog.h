#import <Foundation/Foundation.h>

#define DEFAULT_LOG_NAME @"batterylog.dat"

typedef enum {
    BATTERY,
    AC_POWER
} PowerSource;

typedef enum {
    NO_EVENT, // Should be something like BATTERY_POLL?
    STARTUP,
    SHUTDOWN,
    SLEEP,
    WAKE
} EventType;

// Not a great name.
@interface Datapoint : NSObject <NSCoding>

@property (readonly) NSDate *timestamp;
@property (readonly) int charge;
@property (readonly) PowerSource source;
@property (readonly) EventType event;

@end

@interface BatteryLog : NSObject

@property (readonly) NSArray *data;

- (void) appendEntryWithEvent:(EventType)event;

- (BatteryLog*) initWithFile:(NSString*)filename;
- (void) saveToFile:(NSString*)filename;

@end
