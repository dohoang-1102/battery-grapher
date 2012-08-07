#import "Enum.h"

@interface PowerSource : Enum

EnumDecl(PowerSource, BATTERY)
EnumDecl(PowerSource, AC_POWER)

@end

@interface EventType : Enum

EnumDecl(EventType, NO_EVENT)
EnumDecl(EventType, POLL)
EnumDecl(EventType, STARTUP)
EnumDecl(EventType, SHUTDOWN)
EnumDecl(EventType, SLEEP)
EnumDecl(EventType, WAKE)

@end