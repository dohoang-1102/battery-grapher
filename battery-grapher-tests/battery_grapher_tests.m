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

- (void)setUp{
    [super setUp];
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    [super tearDown];
}

- (void)testLogAppend {
    BatteryLog *log = [[BatteryLog alloc] init];
    STAssertTrue([[log data] count] == 0, @"Log should be empty; had %d entries.", [[log data] count]);
    [log appendEntryWithEvent:NO_EVENT];
}

@end
