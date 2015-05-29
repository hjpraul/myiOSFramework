//
//  UIImage+Create.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Create)

// 创建纯色图片
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

// 视图转图片
+ (UIImage *)imageWithView:(UIView *)view;
@end
