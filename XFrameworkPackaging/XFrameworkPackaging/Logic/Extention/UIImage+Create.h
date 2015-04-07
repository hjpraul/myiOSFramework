//
//  UIImage+Create.h
//  CHLightHandle
//
//  Created by hjpraul on 15/3/6.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Create)
// 生成圆角图片
- (id)roundedRectImageWithSize:(CGSize)size radius:(NSInteger)radius;
// 创建纯色图片
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
