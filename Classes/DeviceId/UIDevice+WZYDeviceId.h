//
//  UIDevice+WZYDeviceId.h
//  WZYDevice
//
//  Copyright (c) 2013 makoto_kw, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString* const WZYDeviceIdUUIDKey;
FOUNDATION_EXPORT NSString* const WZYDeviceIdUUIDOnlyDeviceKey;
FOUNDATION_EXPORT NSString* const WZYDeviceIdService;
FOUNDATION_EXPORT NSString *const WZYDeviceIdErrorDomain;

@interface UIDevice (WZYDeviceId)

@property (readonly) NSString *wzy_deviceUUID;
@property (readonly) NSString *wzy_deviceUUIDOnlyDevice;

@end
