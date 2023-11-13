//
//  MobilityAPI.h
//  MobilitySDK
//
//  Created by Matej Trbara on 08/08/2017.
//
//

#ifndef MobilityAPI_h
#define MobilityAPI_h

#import "MobilitySDKDelegate.h"
#import "BluetoothStates.h"
#import "SDKErrors.h"
#import "BluetoothDeviceCustom.h"
#import "DetectedBeacon.h"
#import "HeartbeatFrequency.h"
#import "SDKSensorsFrequency.h"

/**
 * Main class to interact with MobilitySDK
 * Make sure you have only one reference to this class
 *
 */

@interface MobilityAPI : NSObject

/**
 * @param delegate MobilitySDKDelegate delegate
 * @return instance
 */
- (instancetype _Nonnull)initWithDelegate:(id<MobilitySDKDelegate> _Nullable)delegate;

/**
 * Automatic upload trip after recording is done
 * @param autoUpload should upload after recording is done
 * @note  Default YES
 */

- (void)setAutoUploadEnabled:(BOOL)autoUpload;

/**
 *
 *@return BOOL indicating is auto upload enabled
 */
- (BOOL)getAutoUploadEnabled;

/**
 * If enabled SDK automattically stop trip when non drive detected
 * @param enabled should automatic stop recording
 * @note  Default YES
 */
- (void)setAutoStopEnabled:(BOOL)enabled;

/**
 * @return YES if autoStop enabled.
 */
- (BOOL)getAutoStopEnabled;

// MARK: - Api
// SDK API configuration
/**
 * This method should be called after login. If this method not called sdk wont work.
 * @param driverId Driver id provided by API
 * @param sharedSecret API shared secret
 * @param driverToken token provided by API after login
 * @param vehicle provided by API
 */
- (void)setApiParameters:(NSString * _Nonnull)driverId
            sharedSecret:(NSString * _Nonnull)sharedSecret
             driverToken:(NSString * _Nonnull)driverToken
               vehicleId:(NSString * _Nullable)vehicle;

/// Define url for upload trips. Should be formatted "https://client-specific."
/// Before server host was part of setApiParameters function and was full url.
/// @param prefix client specific https prefix.
- (void)setTripUploadURLPrefix:(NSString * _Nonnull)prefix;

/**
 *Return cached driver token if any
 * @return cached driver token
 */
- (NSString * _Nullable)getDriverToken;

/**
 * Remove driverId, driverToken, vehicle,  tripUploadString and stops sensing and recording.
 * Call this method after user logut.
 */
- (void)clearAllUserData;

// MARK: - Parental control
/**
 * Parental control option. Determine if user is being tracked. This should be get from api.
 * @param isTracked BOOL
 * @note Default NO
 */
- (void)setBeingTracked:(BOOL)isTracked;
/**
 * Parental control option
 * @note Default NO
*/
- (void)setGeofenceBeingTracked:(BOOL)isTracked;

// MARK: - Trips
/**
 * Default trip name after sdk detect and record drive
 * @param tripName name of trip
 * @note default value "TRIP"
 */
- (void)setDefaultTripName:(NSString * _Nonnull)tripName;

/**
 * Rename current trip if any.
 * @param name New name of current trip. Overrides default trip name
 */
- (void)setCurrentTripName:(NSString * _Nonnull)name;

/**
 * @return Distance in kilometers for current/last drive.
 */
- (double)getCurrentTripDistance;

/**
 * SDK tries sync time with ntp and do various calculation to prevent time manipulation.
 * In most of the cases it would be correct NTP time. If not, it will be monotonic.
 * @note Check if isRecording first to use this method
 * @return System start time in miliseconds
 */
- (double)getCurrentTripStartTime;
/**
 * @return trip duration in milliseconds
 */
- (double)getTripDuration;
/**
 * If trip was recorded and have distance less then "distance" it will be deleted.
 * @param distance Threshold for drive to be deleted if < minimum distance -> remove it.
 */
- (void)setMinimumTripDistanceInKm:(double)distance;

/**
 * @return Threshold for drive distance deletion
 */
- (double)getMinimumTripDistanceInKm;

// MARK: - Sensors and metadata configuration
/**
 * If enabled SDK collect all kind of metada
 * @param enabled if YES SDK collects and store all necessary data for user profile on backedn.
 * @note Default YES
 */
- (void)setMetaDataSensingEnabled:(BOOL)enabled;
/**
 * @return YES if metada data collectin is enabled
 */
- (BOOL)getMetaDataSensingEnabled;

/**
 * Enables sensors data collection (accelerometer, gyro, magnetometer). If NO sensing and recording not collecting gyro, magnetometar and acc sensors data. But ABC calculation will work.
 * @param enabled BOOL indicating should enabled raw sensors collection.
 * @note Default NO
 */
- (void)setRawSensorDataCollection:(BOOL)enabled;
/**
 * @return YES if raw sensors data is enabled
 */
- (BOOL)getRawSensorDataCollection;

/**
 * Enables sensors (accelerometer, gyro, magnetometer) collection in sensing. SetRawSensorDataCollection overrides sensing part.
 * Enable rawSensorsDataCollection to have this feature
 * @param enabled BOOL indicating should collects sensors in sensing.
 * @note Default NO
 */
- (void)setSensorRecordingInSensingEnabled:(BOOL)enabled;
/**
 * @return YES if collecting sensors data in sensing enabled
 */
- (BOOL)isSensorRecordingInSensingEnabled;

// MARK: - Battery level

/**
 * When reach this level SDK stop sensing and recording. Default is  0 - nothing happend.
 * When batterylevel > threshold we resume SDK and works as is configured
 * @params perc 'int' percentage of battery when SDK should do battery saving operations (stopRecording, stopSensing ) - need to be configured.
 * Options to configure:
 * @see setLowBatteryNotificationEnabled
 * Localizations:
 * LOW_BATTERY_NOTICICATION_TITLE
 * LOW_BATTERY_NOTICICATION_TEXT
 */
- (void)setBatteryWarningLevel:(int)perc;
/**
 * @return battery warning level
 */
- (int)getBatteryWarningLevel;
/**
 * @return YES if battery level <= batteryWarningLevel
 */
- (BOOL)isBatteryLow;
/**
 * Stops recording when reach BatteryWarninngLevel
 * @note NO default value
 */
- (void)setLowBatteryStopRecording:(BOOL)enabled;
/**
 * @return YES if sdk should stop recording when battery reach threshold value
 */
- (BOOL)getLowBatteryStopRecording;
/**
 * Stop sensing when reach BatteryWarningLevel
 * @note NO default
 */
- (void)setLowBatteryStopSensing:(BOOL)enabled;

/**
 * @return YES if sdk should stop sensing when battery reach threshold value
 */
- (BOOL)getLowBatteryStopSensing;

/**
 * @param enabled YES if you want notify user that about certan battery threshold value reached
 * @note NO default
 */
- (void)setLowBatteryNotificationEnabled:(BOOL)enabled;
/**
 * @return YES if low battery notification is enabled
 */
- (BOOL)getLowBatteryNotificationEnabled;

// MARK: - Other
/**
 * Flag for enabling or disabling bluetooth feature.
 * @param enabled YES to enable bluetooth features
 * @note Default NO
 */
- (void)setBluetoothTrackingEnabled:(BOOL)enabled;
/**
 * @return YES if bluetooth feature are enabled
 */
- (BOOL)getBluetoothTrackingEnabled;
/**
 * SDK have two modes high and low sensing. In low sensing sdk are configured for minimum battery usage. High sensing are configured for better trip detection.
 * @param enabled 'bool'
 * @note Default NO
 */
- (void)setPowerSensingEnabled:(BOOL)enabled;
/**
 * @return BOOL indicating is High power sensing enabled. NO is default value
 */
- (BOOL)isPowerSensingEnabled;

/**
 * @return YES if Low Power Mode is enabled on an iOS device.
 */
- (BOOL)isPowerSavingMode;

/**
 * Notify user when app is terminated
 * @param enabled YES if notification should be shown when app terminated
 * @note Notification title and text should be provided
 * APPLICATION_TERMINATED_NOTIFICATION_TITLE
 * APPLICATION_TERMINATED_NOTIFICATION_TEXT
 */
- (void)setShowAppTerminatedNotification:(BOOL)enabled;

/**
 * @return YES notification is shown on app termination
 */
- (BOOL)getShowAppTerminatedNotification;
/**
 * Notfiy user when recording started
 * @param enabled YES if notification is shown when trip  recording started.
 * @note Default NO
 */
- (void)setShowRecordingNotification:(BOOL)enabled;
/**
 * @return YES if notification is shown when trip recording started
 */
- (BOOL)getShowRecordingNotification;

/**
 * Upload drives only on WIFI. SDK detect changes and upload when WIFI connection detected.
 * @param shouldUseWifiOnly
 * @note Default NO
 */
- (void)setUploadUsingWifiOnly:(BOOL)shouldUseWifiOnly;
/**
 * @return YES if trip can be uploaded only via WIFI
 */
- (BOOL)getUploadUsingWifiOnly;

/**
 * Enables activity tracking
 * @param enabled
 * @note Default YES
 */
- (void)setActivityTrackingEnabled:(BOOL)enabled;

//END setup

/**
 *SDK starts automatc drive recording and detection. This method will fail if you did not set Driver token or missing Motion or Location permission
 * @return SDKError enum SDKErrorNone if there is no issues
 */
- (SDKError)startAutomaticRecording;

/**
 * @brief Stops automatic driving recording and detection
 */
- (void)stopAutomaticRecording;

/**
 * @return YES if automatic recording is in progress. Sensing in progress
 */
- (BOOL)isAutomaticRecordingInProgress;
/**
 @return YES if automatic recording allowed
 */
- (BOOL)isAutomaticRecordingEnabled;

/**
 * Set automatic recording value
 * Method for setting the automaticRecordingEnabled value. You can also call startAutomaticRecording - this methods set and start sensing.
 * @param enabled BOOL indicating if auto recording is enabled
 * @note Default YES
 */
-(void)setAutoRecordingEnabled:(BOOL)enabled;

/**
 * Starts recording of new trip (if able).
 * @return return NO if recording already running
 */
- (BOOL)startRecording;

/**
 * Stops the recording proces of current trip.
 * If autoUpload is set, MobilitySDK will try to uplaod the currently finished trip to server.
 */
- (void)stopRecording;

/**
 * @return YES if currently recording a trip, NO otherwise
 */
- (BOOL)isRecording;

/**
 * @return Number of drives currently recorded on the phone which aren't synchronized/uplaoded to server
 * @note After the drive is uploaded to server it is removed from the device.
 */
- (int)numberOfUnsyncedTrips;

/**
 * Uploads all trips that are recorded on the device but not uploaded to the server.
 */
- (void)uploadAllUnsyncedTrips;

/**
 * Deletes all unsynced drives.
 * if the recording process is active, currently recorded drive will not be cleared.
 */
- (void)deleteAllUnsyncedTrips;


// MARK: - Permissions
// MARK: - Location permission
/**
 * To work properly SDK needs always permission. We encurage developer to use step by step location permission. If authorization status == kCLAuthorizationStatusNotDetermined ask for whenInUse permission
 * @see requestWhileLocationPermission
 * In sdk delegate (MobilitySDKDelegate) method you can get status update and affter whenInUse granted ask for always permission.
 * @see requestLocationPermission
 * This flow is simple and educate user why we need always permission
 * @return YES if location permissions == kCLAuthorizationStatusAuthorizedAlways, SDK should work properly
 */
- (BOOL)hasLocationPermission;

/**
 * This method ask location manager for authorization status. If user did not interact or did not asked for permission manager returns kCLAuthorizationStatusNotDetermined
 * @return YES if location permission != kCLAuthorizationStatusNotDetermined
*/
- (BOOL)hasAskedForLocationPermission;

/**
 * Requests always location permissions from the operating system.
 */
- (void)requestLocationPermission;

/**
 * Requests when in use location permissions from the operating system.
 */
- (void)requestWhileLocationPermission;

// MARK: - Motion permission
/**
 * @return YES if activity manager permissions are allowed
 */
- (BOOL)hasMotionActivityPermission;

/**
 * Requests activity motion permissions from the operating system.
 * @note iOS does not have delegate method for motion permission changes. Calling this method is suggested way to obtain activity motion permission. In case you have in app permission handler it's mandatory to call startAutomaticRecording in order to detect permission
 */
- (void)requestMotionActivityPermission;

// MARK: - Notification permission
/**
 * @return YES if have notification permission
*/
- (BOOL)hasNotificationPermission;

/**
 * Requests notification permissions from the operating system.
 */
- (void)requestNotificationPermission;

// MARK: - Bluetooth
/**
 * Returns status of bluetooth permission
 * @return YES if SDK have permission
 * @see isBluetoothAvailableAndOn
 */
- (BOOL)hasBluetoothPermission;

/**
 * iOS does not built in method for asking bluetooth permission. SDK have implemented internal state tracking and logic to have such option.
 * When this method is called SDK init CBCentralManager wich automatically ask for permission.
 */
- (void)requestBluetoothPermission;

/**
 * @return YES if have permission and bluetooth is ON
 */
- (BOOL)isBluetoothAvailableAndOn;

/**
 * @return YES if bluetooth device is paired, connected and set as car bluetooth address
*/
- (BOOL)isBluetoothDeviceConnected;

/**
 * Searching for connected devices. Note: device should be connected and paired from bluetooth phone settings. You should test it only with bluetooth car connection.
 * @discussion See delegate methods to get proper scaning updates
 * @see bluetoothConnectedScanStarted;
 * @see bluetoothConnectedScanFinished;
 */
- (void)startScanForConnectedDevices;

/**
 * @return array of connected bluetooth devices (BluetoothDeviceCustom). You will not get device if its not paired and connected in phone settings.
 */
- (NSArray<BluetoothDeviceCustom *> *_Nonnull)getConnectedBluetoothDevices;

/**
 *  Connect to specific bluetoothDevice
 * @param uuid device uuid from connected devices
 */
- (void)connectToDeviceWithUUID:(NSString * _Nonnull)uuid;

/**
 * @return state of bluetooth.
 */
- (BluetoothState)getBluetoothState;

/**
 * Disconnect from connected bluetooth device
 */
- (void)disconnectFromBluetooth;

/**
 * @return name of connected bluetooth device if any
 */
- (NSString * _Nullable)userCarBluetoothName;

// MARK: - Beacons

- (void)setBeaconDetectionEnabled:(BOOL)enabled;
- (BOOL)getBeaconDetectionEnabled;
- (void)setBeaconScanningEnabled:(BOOL)enabled;
- (BOOL)getBeaconScanningEnabled;
- (void)setTagOnBeaconDetection:(BOOL)enabled;
- (BOOL)getTagOnBeaconDetection;
- (void)setBeaconProximityConnect:(BOOL)enabled;
- (BOOL)getBeaconProximityConnect;
- (void)setBeaconScanningUuid:(NSString *)uuid;
- (NSString *)getBeaconScanningUuid;
- (NSArray<DetectedBeacon *> * _Nonnull)getDetectedBeacons;
- (void)setBeaconDetails:(DetectedBeacon * _Nullable)beacon;
- (DetectedBeacon * _Nullable)getBeaconDetails;
- (BOOL)isPairedBeaconInRange;


// MARK: - HELPERS
//

/**
 * @return Returns a Boolean value indicating whether location services are enabled on the device.
 */
- (BOOL)isGPSEnabled;

/**
 * @return Returns the last GPS point received by CLLocationManager (nil if none received yet).
 */
- (CLLocation * _Nullable)getLastPoint;

/**
 * @return Returns a Boolean value indicating whether location services have CLAccuracyAuthorizationFullAccuracy. If iOS < 14 return YES
 */
- (BOOL)haveFullAccuarcy;

/**
 * Opens general settings
 */
- (void)openSettings;

/**
 * Opens Application settings
 */
- (void)openAppSettings;

/**
 * @return YES if phone is connected on wifi or wan
*/
- (BOOL)isNetworkEnabled;

/**
 * @return YES if app's current state is background.
 */
- (BOOL)isApplicationInBackground;

/**
 * @return current MobilitySDK version
 */

- (NSString * _Nonnull)getSDKVersion;

/**
 * Call this methods in non native implementations.
 */
- (void)appTerminated;

/**
 * Call this methods in non native implementations.
 */
- (void)appEnterForeground;

/**
 * Call this methods in non native implementations.
 */
- (void)appEnterBackground;

// MARK: - Only debug mode
/**
 * This method is for custom logs. Works only in debug mode.
 * @param message message you want persist in SDK log.
 */
- (void)writeToLog: (NSString * _Nonnull)message;

// MARK: - Heartbeat
/**
 * @return current HB frequency
 */
- (HeartbeatFrequency)getHeartbeatFrequency;
/**
 * @param freq set and cache enumerated value for heartbeat frequency
 */
- (void)setHeartbeatFrequency:(HeartbeatFrequency)freq;
/**
 * Force configuration of all requerd heartbeat settings.
 */
- (void)refreshHeartbeatFrequencies;
/**
 * @param heartbeatStringUrl example of string heartbeat url https://example.drivercopilot.com/api/heartbeat/
 */
- (void)setHeartbeatUrl:(NSString * _Nonnull)heartbeatStringUrl;

// MARK: -
/**
 * This method is only working in debug. It opens mail form with attached logs.
 * @param email email to send logs
 */
- (void)sendLogToEmail:(NSString * _Nonnull)email;


// MARK: - Sensors data frequency

/**
 Setting collecting frequency for accelerometer, magnetometer and gyroscope
 @param freq frequency of sensors collection
 */

- (void)setSensorsDataFrequency:(SDKSensorsFrequency)freq;
/**
 * @return current sensors frequency. Default value 15hz (SDKSensorsFrequency15). You can not change this value
 */
- (SDKSensorsFrequency)getSensorsFrequency;

@end

#endif /* MobilityAPI_h */

