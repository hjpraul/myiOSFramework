//
//  XFPUserDefaults.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/7/10.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFPUserDefaults : NSUserDefaults
+ (void)setLastVersion;
+ (NSString *)lastVersion;
@end
