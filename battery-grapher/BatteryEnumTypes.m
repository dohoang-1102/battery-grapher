#import "BatteryEnumTypes.h"

@implementation PowerSource

EnumImpl(PowerSource, BATTERY)
EnumImpl(PowerSource, AC_POWER)

@end

@implementation EventType

EnumImpl(EventType, NO_EVENT)
EnumImpl(EventType, STARTUP)
EnumImpl(EventType, SHUTDOWN)
EnumImpl(EventType, SLEEP)
EnumImpl(EventType, WAKE)

@end