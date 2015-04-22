//
//  NSString+Convert.m
//  CHLightHandle
//
//  Created by hjpraul on 15/3/3.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "NSString+Code.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Convert)
- (NSString *)base64Encode{
    NSData* originData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encodedData = [GTMBase64 encodeData:originData];
    NSString *encodeStr = [[NSString alloc] initWithData:encodedData encoding:NSUTF8StringEncoding];
    return encodeStr;
}

- (NSString *)base64Decode{
    NSData* encodedData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData* decodeData = [GTMBase64 decodeData:encodedData];
    
    NSString *decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return decodeStr;
}

// -Url encode
-(NSString *)urlEncode {
    NSString * encodedString = (NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
    return encodedString;
    
}

// -Url decode
-(NSString *)urlDecode {
    NSString *tempStr = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString *decodeString = [tempStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return decodeString;//[decodeString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    
}

- (NSString *)md5Encode {
    const char *ptr = [self UTF8String];
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    return output;
}
@end
