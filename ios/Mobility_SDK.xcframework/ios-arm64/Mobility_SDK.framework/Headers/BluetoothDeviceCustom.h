//
//  BluetoothDeviceCustom.h
//  MobilitySDK
//
//  Created by Bruno Blazinc on 15/01/2019.
//
//

#ifndef BluetoothDeviceCustom_h
#define BluetoothDeviceCustom_h

#import <Foundation/Foundation.h>


/**
 * This class is part of Bluetooth trip tagging feature.
 * You need explicitly enable bluetooth tracking feature
 * @see MobilityApi.setBluetoothTrackingEnabled:(BOOL)enabled;
 * @note bluetoothTracking is disabled by default
 *
 */

@interface BluetoothDeviceCustom : NSObject <NSCoding>

/**
 * Connected device name
 */
@property (nonatomic, strong) NSString* name;

/**
 * Connected device uuid
 */
@property (nonatomic, strong) NSString* uuid;

/**
 * YES if it is parsed user device (car)
 */
@property (nonatomic, assign) BOOL isConnected;

/**
 * @param name device name
 * @param uuid uuid of device
 * @return instance
 */
- (instancetype)initWithName:(NSString*)name andUuid:(NSString*)uuid;

@end

#endif /* BluetoothDeviceCustom_h */
