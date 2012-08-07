//
//  battery_grapher_tests.m
//  battery-grapher-tests
//
//  Created by Sean Kelley on 8/6/12.
//  Copyright (c) 2012 Sean Kelley. All rights reserved.
//

#import "battery_grapher_tests.h"
#import "BatteryLog.h"

@implementation battery_grapher_tests

- (void) setUp {
    [super setUp];
    // Set-up code here.
}

- (void) tearDown {
    // Tear-down code here.
    [super tearDown];
}

- (void) testLogAppend {
    BatteryLog *log = [[BatteryLog alloc] init];
    NSArray *logData = [log data];
    STAssertTrue([logData count] == 0, @"Log should be empty; had %d entries.", [logData count]);
    
    [log appendEntryWithEvent:EventType.NO_EVENT];
    usleep(100000);
    [log appendEntryWithEvent:EventType.NO_EVENT];
    usleep(100000);
    [log appendEntryWithEvent:EventType.NO_EVENT];
    logData = [log data];
    STAssertTrue([logData count] == 3, @"Log should have 3 entries; it had %d.", [logData count]);
    
    Datapoint *first =  [logData objectAtIndex:0];
    Datapoint *second = [logData objectAtIndex:1];
    Datapoint *third =  [logData objectAtIndex:2];
    
    NSComparisonResult c;
    c = [first compare:second];
    STAssertTrue(c == NSOrderedAscending, @"Datapoints logged out of order.");
    c = [second compare:third];
    STAssertTrue(c == NSOrderedAscending, @"Datapoints logged out of order.");
}

@end
