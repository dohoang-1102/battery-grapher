//
//  BatteryPolling.m
//  battery-grapher
//
//  Created by Walker Holahan on 8/6/12.
//  Copyright (c) 2012 Sean Kelley, Walker Holahan. All rights reserved.
//

#import "NotificationPoller.h"

#define DEFAULT_POLL_INTERVAL 1.0

@interface NotificationPoller ()
@property (nonatomic) NSTimer *pollTimer;
@end

@implementation NotificationPoller

@synthesize log;
@synthesize pollTimer;

-(NotificationPoller *)initWithLog:(BatteryLog*)l {
    self = [super init];
//    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
//                                                           selector:@selector(onSleep:)
//                                                               name:NSWorkspaceDidActivateApplicationNotification
//                                                             object:nil];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(onWake:)
                                                               name:NSWorkspaceDidWakeNotification
                                                             object:nil];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(onSleep:)
                                                               name:NSWorkspaceWillSleepNotification
                                                             object:nil];
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

- (void) onPoll {
    [log appendEntryWithEvent:EventType.NO_EVENT];
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
