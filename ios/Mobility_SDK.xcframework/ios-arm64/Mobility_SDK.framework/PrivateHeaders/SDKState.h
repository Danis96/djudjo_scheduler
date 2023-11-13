//
//  SDKState.h
//  MobilitySDK
//
//  Created by Marinko Radić on 21.06.2021..
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Indicating  SDK states of the MobilitySDKFramework
 */
typedef NS_ENUM(NSInteger, SDKState) {
    /// SDK state where where location manager have better accuracy, and other sensors settings may be have better acc or sampling rate
    SDKStateHighSensing,
    /// SDK state where sdk collecting minimum data
    SDKStateLowSensing,
    /// SDK detect driving and recording drive (or other activities- in future)
    SDKStateRecording,
    /// SDK is in hibernate mode there are no any kind of activity detected, we try to save energy
    SDKStateHibernate,
    /// SDK is in power saving mode, user set from which battery level does not sdk to be active
    SDKStateBatterySaving
    
};


NS_ASSUME_NONNULL_END
