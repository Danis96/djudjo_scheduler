//
//  Localization.h
//  Extension
//
//  Created by Luka Mijatovic on 06/12/16.
//
//

#import <Foundation/Foundation.h>

///Key for auto recording start notification title
extern const NSString* AUTO_RECORDING_STARTED_NOTIFICATION_TEXT;
///Key for auto recording stopped notification title
extern const NSString* AUTO_RECORDING_STOPPED_NOTIFICATION_TEXT;
///Key for driving start notification title. This shows up if autorecording is disabled. User get notification for driving start detection but wont automatically record it.
extern const NSString* DRIVING_STARTED_NOTIFICATION_TEXT;
///Key for driving start notification title. This shows up if autorecording is disabled. User get notification for driving stop detection but wont automatically record it.
extern const NSString* DRIVING_STOPPED_NOTIFICATION_TEXT;
///Key for application termination notification title.
extern const NSString* APPLICATION_TERMINATED_NOTIFICATION_TITLE;
///Key for application termination notification body.
extern const NSString* APPLICATION_TERMINATED_NOTIFICATION_TEXT;
///Key for low battery notification title. This shows up if you are under  - (void)setBatteryWarningLevel:(int)perc; threshold.
extern const NSString* LOW_BATTERY_NOTIFICATION_TITLE;
///Key for low battery notification body. This shows up if you are under  - (void)setBatteryWarningLevel:(int)perc; threshold.
extern const NSString* LOW_BATTERY_NOTIFICATION_TEXT;

/**
 * Localization class for mobilitySDK.
 * If You have in app language change feature. After localization change you should translate all strings.
 * Currently we dont support multilanguage translations.
 */

@interface Localization : NSObject

/**
 * Get localization for key. Key-value paradigm. All available keys are specified as constants in this class.
 * @param key Key for specific localization.
 * @return Localized value for specified key `NSString`.
 */
+ (NSString*)stringForKey:(NSString*)key;
/**
 * Add localization for specific key.
 * @param string Translation value for key
 * @param key Key for translation
 */
+ (void)addString:(NSString*)string forKey:(const NSString*)key;

@end
