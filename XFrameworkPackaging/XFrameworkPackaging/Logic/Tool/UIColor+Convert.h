//
//  UIColor+Convert.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Convert)
// 字符串转颜色 #RRGGBB格式
+(UIColor *)colorWithString:(NSString *)str;
@end
