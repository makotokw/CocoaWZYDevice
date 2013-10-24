//
//  UIDevice+WZDeviceId.h
//  WZDevice
//
//  Copyright (c) 2013 makoto_kw, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString* const WZDeviceIdUUIDKey;
FOUNDATION_EXPORT NSString* const WZDeviceIdUUIDOnlyDeviceKey;
FOUNDATION_EXPORT NSString* const WZDeviceIdService;
FOUNDATION_EXPORT NSString *const WZDeviceIdErrorDomain;

@interface UIDevice (WZDeviceId)

@property (readonly) NSString *deviceUUID;
@property (readonly) NSString *deviceUUIDOnlyDevice;

@end
