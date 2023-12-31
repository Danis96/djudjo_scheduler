//
//  Constants.h
//  MobilitySDK
//
//  Created by Matej Trbara on 08/08/2017.
//
//

#ifndef Constants_h
#define Constants_h

#import <Foundation/Foundation.h>

extern const int USER_MODE_NOT_DRIVING;
extern const int USER_MODE_DRIVING;

extern NSString* const APPLICATION_LAUNCHED_NOTIFICATION_NAME;
extern NSString* const APPLICATION_WILL_RESIGNE_NOTIFICATION_NAME;
extern NSString* const APPLICATION_ENTERED_BACKGROUND_NOTIFICATION_NAME;
extern NSString* const APPLICATION_WILL_ENTER_FOREGROUND_NOTIFICATION_NAME;
extern NSString* const APPLICATION_BECAME_ACTIVE_NOTIFICATION_NAME;
extern NSString* const APPLICATION_TERMINATED_NOTIFICATION_NAME;
extern NSString* const LOCATION_MANAGER_DID_CHANGE_AUTHORIZATION_STATUS;
extern NSString* const LOCATION_MANAGER_DID_CHANGE_ACCURACY_STATUS;
extern NSString* const MOTION_ACTIVITY_PERMISSION_CHANGED;
extern NSString* const HAS_ASKED_NOTIFICATION_PERIMISSION;
extern NSString* const HAS_ASKED_MOTION_PERMISSION;
extern NSString* const DID_ENTER_PAIRED_BEACON_REGION_NOTIFICATION_NAME;
extern NSString* const DID_EXIT_PAIRED_BEACON_REGION_NOTIFICATION_NAME;

#endif /* Constants_h */
