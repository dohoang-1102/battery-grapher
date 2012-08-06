#import <Foundation/Foundation.h>

typedef enum powerSource {
    BATTERY,
    AC_POWER
} PowerSource;

typedef enum eventType {
    NO_EVENT, // Should be something like BATTERY_POLL?
    STARTUP,
    SHUTDOWN,
    SLEEP,
    WAKE
} EventType;

// Not a great name.
typedef struct datapoint {
    long timestamp;
    int charge;
    PowerSource source;
    EventType event;
} Datapoint;


@interface BatteryLog : NSObject

@property (readonly) NSArray *data;

- (void) appendEntryWithEvent:(EventType)event;

- (BatteryLog*) initWithFile:(NSString*)filename;
- (void) saveToFile:(NSString*)filename;

@end
