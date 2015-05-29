//
//  NSString+Convert.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Code)
- (NSString *)base64Encode;
- (NSString *)base64Decode;

-(NSString *)urlEncode;
-(NSString *)urlDecode;

- (NSString *)md5Encode;
@end
