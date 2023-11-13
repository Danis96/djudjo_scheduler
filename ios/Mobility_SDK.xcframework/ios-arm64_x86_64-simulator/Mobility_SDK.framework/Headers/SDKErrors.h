//
//  SDKErrors.h
//  MobilitySDK
//
//  Created by Marinko Radić on 31/08/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * Indicating error on SDK start. If there is no error SDKErrorNone should be returned
 */
typedef NS_ENUM(NSInteger, SDKError) {
    /// Location service is disabled. Users can enable or disable location services by toggling the Location Services switch in Settings > Privacy. 
    SDKErrorLocationServiceDisabled,
    /// Didn't ask for location permission
    SDKErrorLocationPermissionNotDetermined,
    /// Location Permission denied
    SDKErrorLocationPermissionDenied,
    /// Motion Permission denied
    SDKErrorMotionPermissionDenied,
    /// Motion Permission Not Determined
    SDKErrorMotionPermissionNotDetermined,
    /// SDK cant run because battery is too low
    SDKErrorLowBattery,
    /// SDK already runing, ignore it
    SDKErrorAlreadyRunning,
    /// SDK don't have user token
    SDKErrorMissingDriverToken,
    /// SDK missing vehicleID
    SDKErrorMissingVehicleID,
    /// Wrong configuration can't start
    SDKErrorWrongConfiguration,
    /// SDK does not have full gps accuracy
    SDKErrorFullAccuracy,
    /// No errors, all good
    SDKErrorNone
};

NS_ASSUME_NONNULL_END
