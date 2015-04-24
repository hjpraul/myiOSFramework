//
//  UIImage+Create.h
//  CHLightHandle
//
//  Created by hjpraul on 15/3/6.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Create)

// 创建纯色图片
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

// 视图转图片
+ (UIImage *)imageWithView:(UIView *)view;
@end
