//
//  MobilitySDKDelegate.h
//  MobilitySDK
//
//  Created by Matej Trbara on 08/08/2017.
//
//

#ifndef MobilitySDKDelegate_h
#define MobilitySDKDelegate_h

#import "DetectedBeacon.h"
#import "PhoneCallState.h"

@class CLLocation;

/**
 * Delegate methods of MobilitySDK. This protocol should be implement to received events from SDK such as driving started, permission changed, etc.
 */
@protocol MobilitySDKDelegate <NSObject>
/**
 * SDK detect driving, this method are called when autoRecordingEnabled settings is off. It means SDK detect driving but not recording.
 */
- (void)drivingStarted;
/**
 * SDK detect driving stop, this method are called when autoRecordingEnabled settings is off. It means SDK detect user not driving anymore.
 */
- (void)drivingStopped;
/**
 * @param status PhoneCallStatus enumeration
 * @param time time at event occured "dd.MM.yyyy. HH:mm:ss" format
 */
- (void)callingWithStatus:(PhoneCallStatus)status time:(NSString * _Nonnull)time;
/**
 * Phone proximity sensor.
 * @param status status of phone proximity sensors near or far
 * @note proximity sensor not working when app is not in foreground
 */
- (void)proximityChangedWithStatus:(PhoneProximityStatus)status;
/**
 * Drive detected and started to record
 */
- (void)recordingStarted;
/**
 * Recording stopped
 */
- (void)recordingStopped;

/**
 * Uploading drives are done. After this method is called you can update numberOfUnsyncedTrips.
 */
- (void)allDrivesUploadFinished;
/**
 * Uploading failed with error
 * @param error error which occured during upload
 */
- (void)allDrivesUploadFailed:(NSError* _Nullable)error;

/// In order for sdk to work reautentification needed.
/// That means SDK received 401 or 403 status code
/// NOTE: SDK on this state does not stop trip recording or activity tracking. You should handle this state.
/// @param error Mobility error with backend status code
- (void)reautentificationNeeded: (NSError * _Nonnull)error;

/**
 * This delegate method are called when SDK is in recording state and received new gps point. You can use that to update driveDistance
 * @param point CLLocation
 */
- (void)gpsPointRecorded:(CLLocation *_Nonnull)point;
/**
 * Bluetooth state changed.
 */
- (void)bluetoothStateChanged;

/**
 * User did enter in paired beacon region
 */
- (void)didEnterPairedBeaconRegion;

/**
 * User did exing paired beacon region
 */
- (void)didExitPairedBeaconRegion;

/**
 * SDK detect beacons
 * @param beacons Array of detected beacon/s
 */
- (void)didDetectBeacons:(NSArray<DetectedBeacon *> * _Nonnull)beacons;

/**
 * Bluetooth sensor is on
 */
- (void)bluetoothSensorOn;
/**
 * Bluetooth sensor is off
 */
- (void)bluetoothSensorOff;

/**
 * Bluetooth tracker start to scan available devices
 */
- (void)bluetoothConnectedScanStarted;

/**
 * Bluetooth tracker scan finished
 */
- (void)bluetoothConnectedScanFinished;

/**
 * Bluetooth device connected
 */
- (void)bluetoothSensorDeviceConnected;

/**
 * Bluetooth device disconnected
 */
- (void)bluetoothSensorDeviceDisconnected;

@end

#endif /* MobilitySDKDelegate_h */
