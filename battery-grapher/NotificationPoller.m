//
//  BatteryPolling.m
//  battery-grapher
//
//  Created by Walker Holahan on 8/6/12.
//  Copyright (c) 2012 Sean Kelley, Walker Holahan. All rights reserved.
//

#import "NotificationPoller.h"
#import <sys/sysctl.h>

#define DEFAULT_POLL_INTERVAL 1.0

@interface NotificationPoller ()
@property (nonatomic) NSTimer *pollTimer;
@end

@implementation NotificationPoller

@synthesize log;
@synthesize pollTimer;

-(NotificationPoller *)initWithLog:(BatteryLog*)l {
    self = [super init];
    int mib[2];
    struct timeval boottime;
    size_t len;
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_BOOTTIME;
    len = sizeof(boottime);
    sysctl(mib, 2, &boottime, &len, NULL, 0);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(boottime.tv_sec)];
  //  NSLog(@"%@", [date descriptionWithLocale:[NSLocale currentLocale]]);
    // TODO throw this at sean's interface to register a machine boot event
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(onWake:)
                                                               name:NSWorkspaceDidWakeNotification
                                                             object:nil];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(onSleep:)
                                                               name:NSWorkspaceWillSleepNotification
                                                             object:nil];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(onPowerOff:)
                                                               name:NSWorkspaceWillPowerOffNotification
                                                             object:nil];

    // TODO later
    // NSWorkspaceScreensDidWakeNotification
    // NSWorkspaceScreensDidSleepNotification
    
    log = l;
    [self setPollInterval:DEFAULT_POLL_INTERVAL];
    return self;
}

- (void) onWake:(NSNotification *)notification {
    [log appendEntryWithEvent:EventType.WAKE];
}

- (void) onSleep:(NSNotification *)notification {
    [log appendEntryWithEvent:EventType.SLEEP];
}

- (void) onPowerOff:(NSNotification *)notification {
    [log appendEntryWithEvent:EventType.SHUTDOWN];
}
- (void) onPoll {
    [log appendEntryWithEvent:EventType.POLL];
}

- (void) setPollInterval:(NSTimeInterval)pollInterval {
    [self setPollTimer:[NSTimer scheduledTimerWithTimeInterval:pollInterval
                                                        target:self
                                                      selector:@selector(onPoll)
                                                      userInfo:nil
                                                       repeats:YES]];
}

- (NSTimeInterval) pollInterval {
    return [[self pollTimer] timeInterval];
}

- (void) setPollTimer:(NSTimer *)t {
    [pollTimer invalidate];
    pollTimer = t;
}

@end
