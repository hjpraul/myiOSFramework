//
//  UIColor+Convert.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "UIColor+Convert.h"

@implementation UIColor (Convert)
// 字符串转颜色 #RRGGBB格式
+(UIColor *)colorWithString:(NSString *)str {
    if (!str) {
        return [UIColor clearColor];
    }
    NSMutableString *tempStr = [NSMutableString stringWithString:str];
    if([tempStr rangeOfString:@"#"].location !=NSNotFound)
    {
        // 转换成标准16进制数
        [tempStr replaceCharactersInRange:[tempStr rangeOfString:@"#" ] withString:@"0x"];
    }
    // 十六进制字符串转成整形。
    long long colorLong = strtoul([tempStr cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B = colorLong & 0x0000FF;
    
    //string转color
    UIColor *retColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    return retColor;
}
@end
