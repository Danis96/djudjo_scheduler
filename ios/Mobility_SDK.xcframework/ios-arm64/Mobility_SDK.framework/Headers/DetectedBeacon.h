//
//  DetectedBeacon.h
//  MobilitySDK
//
//  Created by Branimir Gregov on 11/09/2020.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Beacon model
 * Beacon fature should be enabled explicitly
 * @see MobilityApi.beacons section
 */

@interface DetectedBeacon : NSObject

/**
 * Beacon uuid
 */
@property (nonatomic, strong) NSString *UUID;
/**
 * Most significant value associated with the beacon.
 */
@property (nonatomic, strong) NSNumber *major;
/**
 *  Least significant value associated with the beacon.
 */
@property (nonatomic, strong) NSNumber *minor;

/**
 * Represents the current proximity of an beacon.
 */
@property (nonatomic, assign) CLProximity proximity;
/**
 * @param beacon
 * @return instance
 */
- (instancetype)initWithBeacon:(CLBeacon *)beacon;

@end

NS_ASSUME_NONNULL_END
