//
//  UIImage+Conversion.h
//  UnionSYF
//
//  Created by zhongjin on 14-4-10.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Conversion)
//3张图片的合成
+(UIImage *)addImage1:(UIImage *)image1 withImage:(UIImage *)image2 withImage1:(UIImage *)image3   rect1:(CGRect)rect1 rect2:(CGRect)rect2  rect3:(CGRect )rect3;
+(UIImage *)addImage:(UIImage *)image1 withImage:(UIImage *)image2    rect1:(CGRect)rect1 rect2:(CGRect)rect2;

// 修改图片大小
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;

// 重设图片颜色
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
//设置image
+(UIImage *)imageWithHextring:(NSString *)HexString;

// 图片裁剪
-(UIImage *)imageAtRect:(CGRect)rect;
//设置图片的大小
+(UIImage *)shrinkImage:(UIImage *)pImage withSize:(CGSize)pSize;

//合成虚线
+(UIImage *)CompoundLineImage;
@end
