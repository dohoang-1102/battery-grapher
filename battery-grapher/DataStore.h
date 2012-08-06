#import <Foundation/Foundation.h>

typedef enum powerSource {
    BATTERY,
    AC_POWER
} PowerSource;

typedef enum eventType {
    NONE,
    STARTUP,
    SHUTDOWN,
    SLEEP,
    WAKE
} EventType;

typedef struct dataPoint {
    long timestamp;
    int charge;
    PowerSource source;
    EventType event;
} DataPoint;

@interface DataStore : NSArray

- (DataStore*) initWithFile:(NSString*)filename;
- (void) saveToFile:(NSString*)filename;

@end
