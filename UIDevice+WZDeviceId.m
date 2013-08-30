//
//  UIDevice+WZDeviceId.m
//  WZDeviceId
//
//  Copyright (c) 2013 makoto_kw, Inc. All rights reserved.
//

#import "UIDevice+WZDeviceId.h"

NSString* const WZDeviceIdUUIDKey = @"UUID";
NSString* const WZDeviceIdUUIDOnlyDeviceKey = @"UUIDOnlyDevice";
NSString* const WZDeviceIdService = @"com.makotokw.ios.wheezy.deviceid";
NSString* const WZDeviceIdErrorDomain = @"com.makotokw.ios.wheezy.deviceid";

@implementation UIDevice (WZDeviceId)

@dynamic deviceUUID, deviceUUIDOnlyDevice;

- (NSString *)deviceUUID
{
    NSError *error = nil;
    NSData *uuidData = [UIDevice getDataFromKeychainForKey:WZDeviceIdUUIDKey service:WZDeviceIdService error:&error];
    if (uuidData.length == 0) {
        CFUUIDRef uuid = CFUUIDCreate(nil);
        CFUUIDBytes uuidBytes = CFUUIDGetUUIDBytes(uuid);
        uuidData = [NSData dataWithBytes:&uuidBytes length:sizeof(uuidBytes)];
        [UIDevice setDataToKeychain:uuidData forKey:WZDeviceIdUUIDKey service:WZDeviceIdService accessible:kSecAttrAccessibleAlwaysThisDeviceOnly error:&error];
        if (error) {
            uuidData = nil;
        }
    }
    return [self hexStringWithData:uuidData];
}

- (NSString *)deviceUUIDOnlyDevice
{
    NSError *error = nil;
    NSData *uuidData = [UIDevice getDataFromKeychainForKey:WZDeviceIdUUIDOnlyDeviceKey service:WZDeviceIdService error:&error];
    if (uuidData.length == 0) {
        CFUUIDRef uuid = CFUUIDCreate(nil);
        CFUUIDBytes uuidBytes = CFUUIDGetUUIDBytes(uuid);
        uuidData = [NSData dataWithBytes:&uuidBytes length:sizeof(uuidBytes)];
        [UIDevice setDataToKeychain:uuidData forKey:WZDeviceIdUUIDKey service:WZDeviceIdService accessible:kSecAttrAccessibleAlways error:&error];
        if (error) {
            uuidData = nil;
        }
    }
    return [self hexStringWithData:uuidData];
}

- (NSString *)hexStringWithData:(NSData *)data
{
    if (data.length == 0) {
        return nil;
    }
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:data.length * 2];
    const unsigned char *dataBuffer = (const unsigned char *)data.bytes;
    for (int i=0; i<data.length; i++) {
        [stringBuffer appendFormat:@"%02X", (NSUInteger)dataBuffer[i]];
    }
    return stringBuffer;
}

#pragma mark Keychain

+ (NSData *)getDataFromKeychainForKey:(NSString *)key service:(NSString *)service error:(NSError **)error
{
    if (!key || !service) {
        if (error) {
            *error = [NSError errorWithDomain:WZDeviceIdErrorDomain code:0 userInfo:nil];
        }
        return nil;
    }
    
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    query[(__bridge __strong id)(kSecClass)] = (__bridge id)(kSecClassGenericPassword);
    query[(__bridge __strong id)(kSecReturnData)] = (__bridge id)(kCFBooleanTrue);
    query[(__bridge __strong id)(kSecMatchLimit)] = (__bridge id)(kSecMatchLimitOne);
    query[(__bridge __strong id)(kSecAttrService)] = service;
    query[(__bridge __strong id)(kSecAttrGeneric)] = key;
    query[(__bridge __strong id)(kSecAttrAccount)] = key;
    
    NSData *data = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)(void *)&data);
    if (status != errSecSuccess) {
        if (error) {
            *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil];
        }
        return nil;
    }
    return data;
}

+ (void)setDataToKeychain:(NSData *)data forKey:(NSString *)key service:(NSString *)service accessible:(CFTypeRef)accessible error:(NSError **)error
{
    if (!key || !service) {
        if (error != nil) {
            *error = [NSError errorWithDomain:WZDeviceIdErrorDomain code:0 userInfo:nil];
        }
        return;
    }
    
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    query[(__bridge __strong id)(kSecClass)] = (__bridge id)(kSecClassGenericPassword);
    query[(__bridge __strong id)(kSecAttrService)] = service;
    query[(__bridge __strong id)(kSecAttrGeneric)] = key;
    query[(__bridge __strong id)(kSecAttrAccount)] = key;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, NULL);
    if (status == errSecSuccess) {
        if (data) {
            NSMutableDictionary *attributesToUpdate = [NSMutableDictionary dictionary];
            attributesToUpdate[(__bridge __strong id)(kSecValueData)] = data;
            status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)attributesToUpdate);
        } else {
            [self removeDataFormKeychainForKey:key service:service error:error];
        }
    } else if (status == errSecItemNotFound) {
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[(__bridge __strong id)(kSecClass)] = (__bridge id)(kSecClassGenericPassword);
        attributes[(__bridge __strong id)(kSecAttrService)] = service;
        attributes[(__bridge __strong id)(kSecAttrGeneric)] = key;
        attributes[(__bridge __strong id)(kSecAttrAccount)] = key;
        attributes[(__bridge __strong id)(kSecValueData)] = data;
        attributes[(__bridge __strong id)(kSecAttrAccessible)] = (__bridge id)(accessible);
        
        status = SecItemAdd((__bridge CFDictionaryRef)attributes, NULL);
    }
    if (status != errSecSuccess) {
        if (error) {
            *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil];
        }
    }
}

+ (void)removeDataFormKeychainForKey:(NSString *)key service:(NSString *)service error:(NSError **)error
{
    if (!key || !service) {
        if (error) {
            *error = [NSError errorWithDomain:WZDeviceIdErrorDomain code:0 userInfo:nil];
        }
        return;
    }
    
    NSMutableDictionary *itemToDelete = [NSMutableDictionary dictionary];
    itemToDelete[(__bridge __strong id)(kSecClass)] = (__bridge id)(kSecClassGenericPassword);
    itemToDelete[(__bridge __strong id)(kSecAttrService)] = service;
    itemToDelete[(__bridge __strong id)(kSecAttrGeneric)] = key;
    itemToDelete[(__bridge __strong id)(kSecAttrAccount)] = key;
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)itemToDelete);
    
    if (status == errSecSuccess || status == errSecItemNotFound) {
        if (error) {
            *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil];
        }
    }
}

@end
