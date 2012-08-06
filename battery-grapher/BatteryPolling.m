//
//  BatteryPolling.m
//  battery-grapher
//
//  Created by Walker Holahan on 8/6/12.
//  Copyright (c) 2012 Sean Kelley, Walker Holahan. All rights reserved.
//

#import "BatteryPolling.h"

@implementation BatteryPolling
// -(BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
-(BatteryPolling *)init {
    self = [super init];
//    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
//                                                           selector:@selector(onSleep:)
//                                                               name:NSWorkspaceDidActivateApplicationNotification
//                                                             object:nil];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(onSleep:)
                                                               name:NSWorkspaceDidWakeNotification
                                                             object:nil];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(onSleep:)
                                                               name:NSWorkspaceScreensDidSleepNotification
                                                             object:nil];


    return self;
}

- (void) onSleep:(NSNotification *)notification {
    NSLog(@"%@", [notification name]);
}

@end
