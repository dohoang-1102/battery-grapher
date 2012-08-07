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
    // TODO throw this at sean's interface to register a machine boot event
    log = l;

    [self onBoot];

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
    
    
    [self setPollInterval:DEFAULT_POLL_INTERVAL];
    return self;
}
- (void) onBoot {
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    struct timeval bootTime;
    size_t len = sizeof(bootTime);
    
    sysctl(mib, 2, &bootTime, &len, NULL, 0);
    [log appendBootTimeEntry:[NSDate dateWithTimeIntervalSince1970:(bootTime.tv_sec)]];
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
