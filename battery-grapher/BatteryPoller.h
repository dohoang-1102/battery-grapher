//
//  BatteryPolling.h
//  battery-grapher
//
//  Created by Walker Holahan on 8/6/12.
//  Copyright (c) 2012 Sean Kelley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BatteryLog.h"

@interface BatteryPoller : NSObject

@property (readonly) BatteryLog *log;
@property (nonatomic) NSTimeInterval pollInterval;

- (BatteryPoller*) initWithLog:(BatteryLog*)l;

@end
