//
//  XFPUserDefaults.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/7/10.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPUserDefaults.h"
// 客户端是否首次使用
#define XFP_LAST_VERSION_KEY    @"XFPLastVersion"

@implementation XFPUserDefaults
+ (void)setLastVersion {
    [[NSUserDefaults standardUserDefaults] setObject:APPVERSION forKey:XFP_LAST_VERSION_KEY];
}

+ (NSString *)lastVersion {
    return [[NSUserDefaults standardUserDefaults] objectForKey:XFP_LAST_VERSION_KEY];
}
@end
