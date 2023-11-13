//
//  PhoneCallState.h
//  MobilitySDK
//
//  Created by Marinko Radić on 18/09/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Call type
 */
typedef NS_ENUM(NSInteger, PhoneCallStatus) {
    /// Incoming call
    PhoneCallStatusIncoming,
    /// Outgoing call
    PhoneCallStatusOutgoing,
    /// Call connected
    PhoneCallStatusConnected,
    /// Call disconnected
    PhoneCallStatusDisconnected,
};

/**
 * Value that indicates whether the proximity sensor is close to the user.
 */
typedef NS_ENUM(NSInteger, PhoneProximityStatus) {
    /// Phone is close to the user
    PhoneProximityStatusNear,
    /// Phone is far from the user
    PhoneProximityStatusFar
};
/**
 * Audio output type detected by the SDK
 */
typedef NS_ENUM(NSInteger, AudioOutputType) {
    /// Audio output type is earpiece
    AudioOutputTypeEarpiece,
    /// Audio output type phones built in speaker
    AudioOutputTypeBuiltInSpeaker,
    /// Audio output type is wired headphones
    AudioOutputTypeWiredHeadPhones,
    /// Audio output type is bluetooth device (car, headphones, speaker)
    AudioOutputTypeBtDevice
};


NS_ASSUME_NONNULL_END
