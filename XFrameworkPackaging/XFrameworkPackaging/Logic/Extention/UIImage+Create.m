//
//  UIImage+Create.m
//  CHLightHandle
//
//  Created by hjpraul on 15/3/6.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "UIImage+Create.h"

@implementation UIImage (Create)
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
