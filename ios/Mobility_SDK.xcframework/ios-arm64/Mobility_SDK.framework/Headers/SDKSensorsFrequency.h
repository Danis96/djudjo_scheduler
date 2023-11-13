//
//  SDKSensorsFrequency.m
//  MobilitySDK
//
//  Created by Marinko Radić on 29/03/2021.
//

#import <Foundation/Foundation.h>

#ifndef SDKSensorsFrequency_h
#define SDKSensorsFrequency_h
/**
    SDK Frequency enum for magnetometer, accelerometer and gyroscope
 */
typedef NS_ENUM(NSInteger, SDKSensorsFrequency) {
    /** Collecting data at 5 HZ */
    SDKSensorsFrequency5,
    /** Collecting data at 10 HZ */
    SDKSensorsFrequency10,
    /** Collecting data at 15 HZ */
    SDKSensorsFrequency15,
    /** Collecting data at 20 HZ */
    SDKSensorsFrequency20,
    /** Collecting data at 100 HZ */
    SDKSensorsFrequency100,
    /** Collecting data at fastest rate */
    SDKSensorsFrequencyFastest,
};

#endif
