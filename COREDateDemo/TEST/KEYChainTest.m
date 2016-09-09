//
//  KEYChainTest.m
//  COREDateDemo
//
//  Created by leo on 16/7/27.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "KEYChainTest.h"

#define  KEY_USERNAME_PASSWORD @"com.company.app.usernamepassword"
#define  KEY_USERNAME @"com.company.app.username"
#define  KEY_PASSWORD @"com.company.app.password"

@implementation KEYChainTest

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service{

    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data{

    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];

    SecItemDelete((CFDictionaryRef)keychainQuery);

    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];

    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}


+ (id)load:(NSString *)service{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeyData:(NSString *)service{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

/*
 使用
 +(NSString *)getUUID
 {
 NSString * strUUID = (NSString *)[KEYChainTest load:@"com.company.app.usernamepassword"];

 //首次执行该方法时，uuid为空
 if ([strUUID isEqualToString:@""] || !strUUID)
 {
 //生成一个uuid的方法
 CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);

 strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));

 //将该uuid保存到keychain
 [KEYChainTest save:KEY_USERNAME_PASSWORD data:strUUID];

 }
 return strUUID;
 }
 */

@end
