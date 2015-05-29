//
//  UIImage+Process.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Process)
// 图片合成
+(UIImage *)imageCombinedByImage1:(UIImage *)image1 rect1:(CGRect)rect1
                         image2:(UIImage *)image2 rect2:(CGRect)rect2;

// 图片缩放
- (UIImage *)imageScaledToSize:(CGSize)newSize aspectRatio:(BOOL)aspectRatio;

// 重设图片颜色
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

// 图片裁剪
-(UIImage *)subImageAtRect:(CGRect)rect;

// 生成圆角图片
- (UIImage *)toRoundedRectImageWithSize:(CGSize)size radius:(NSInteger)radius;

@end
