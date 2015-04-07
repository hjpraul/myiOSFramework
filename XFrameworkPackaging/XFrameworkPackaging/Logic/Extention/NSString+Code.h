//
//  NSString+Convert.h
//  CHLightHandle
//
//  Created by hjpraul on 15/3/3.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Convert)
- (NSString *)base64Encode;
- (NSString *)base64Decode;

- (long long)hexValue;

+ (NSString *)hexStringWithLonglong:(long long)longlongValue;
@end
