//
//  BluetoothStates.h
//  MobilitySDK
//
//  Created by Marinko Radić on 18/03/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_CLOSED_ENUM(NSInteger, BluetoothState) {
    BluetoothStatePowerOn,
    BluetoothStateUnauthorized,
    BluetoothStatePowerOff,
    BluetoothStateNotAsked,
    /// Bluetooth feature disabled in SDK Settings
    BluetoothStateSDKDisabled,
};

NS_ASSUME_NONNULL_END
