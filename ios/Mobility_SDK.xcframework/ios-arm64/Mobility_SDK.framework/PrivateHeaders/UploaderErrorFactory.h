//
//  UploaderErrorFactory.h
//  MobilitySDK
//
//  Created by Marinko on 11/20/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UploaderErrorType) {
    /// 400 response
    UploaderErrorTypeBadRequest = 400,
    /// 401 response
    UploaderErrorTypeUnauthorized = 401,
    /// 403 response
    UploaderErrorTypeForbidden = 403,
    /// Payload too large
    UploaderErrorTypePayloadTooLarge = 413,
    /// Other 400 code
    UploaderErrorTypeOther400 = 499,
    /// Other error types
    UploaderErrorTypeNon400 = 31
};

@interface UploaderErrorFactory : NSObject

+ (NSError *)errorForStatusCode:(int)statusCode;
+ (NSError *)uploaderInProgressError;


@end

NS_ASSUME_NONNULL_END
