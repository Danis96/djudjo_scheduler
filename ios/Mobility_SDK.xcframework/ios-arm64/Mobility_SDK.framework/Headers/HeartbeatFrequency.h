//
//  HeartbeatFrequency.h
//  MobilitySDK
//
//  Created by Branimir Gregov on 14/07/2020.
//

#ifndef HeartbeatFrequency_h
#define HeartbeatFrequency_h

#import <Foundation/Foundation.h>
/**
 * Hearthbeat frequency enumeration
 */
typedef NS_ENUM(NSInteger, HeartbeatFrequency) {
    /// Heartbeat is off
    HeartbeatFrequencyNone = 0,
    /// Heartbeat upload interval is 60 minutes and beat interval is 15 minutes
    HeartbeatFrequencyLow,
    /// Heartbeat upload interval is 15 min and beat interval is 5 minutes
    HeartbeatFrequencyMedium,
    /// Heartbeat upload interval is 3 min and beat interval is every 1 minute
    HeartbeatFrequencyHigh
};

#endif /* HeartbeatFrequency_h */

    
