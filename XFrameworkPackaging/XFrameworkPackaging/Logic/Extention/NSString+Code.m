//
//  NSString+Convert.m
//  CHLightHandle
//
//  Created by hjpraul on 15/3/3.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "NSString+Convert.h"
#import "GTMBase64.h"

@implementation NSString (Convert)
- (NSString *)base64Encode{
    NSData* originData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encodedData = [GTMBase64 encodeData:originData];
    NSString *encodeStr = [[NSString alloc] initWithData:encodedData encoding:NSUTF8StringEncoding];
    return encodeStr;
    
//    NSData* originData = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSString* encodeStr = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    return encodeStr;
}

- (NSString *)base64Decode{
    NSData* encodedData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData* decodeData = [GTMBase64 decodeData:encodedData];
    
    NSString *decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return decodeStr;
    
//    NSData* encodedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
//    NSString* decodeStr = [[NSString alloc]
//                           initWithData:encodedData encoding:NSUTF8StringEncoding];
//    return decodeStr;
}

- (long long)hexValue{
    NSMutableString *tempStr = [NSMutableString stringWithString:self];
    if([tempStr rangeOfString:@"#"].location !=NSNotFound)
    {
        // 转换成标准16进制数
        [tempStr replaceCharactersInRange:[tempStr rangeOfString:@"#" ] withString:@"0x"];
    }
    // 十六进制字符串转成整形。
    long long valueLong = strtoul([tempStr cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    return valueLong;
}

+ (NSString *)hexStringWithLonglong:(long long)longlongValue{
    return [NSString stringWithFormat:@"#F%06X",(int)longlongValue];
}

@end
