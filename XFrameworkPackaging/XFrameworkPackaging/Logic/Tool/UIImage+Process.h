//
//  UIImage+Process.h
//  UnionSYF
//
//  Created by zhongjin on 14-4-10.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
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

// 图片切片
- (UIImage *)cropAtRect:(CGRect)rect;
@end
