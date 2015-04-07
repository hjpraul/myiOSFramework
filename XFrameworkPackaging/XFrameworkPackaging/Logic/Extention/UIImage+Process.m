//
//  UIImage+Conversion.m
//  UnionSYF
//
//  Created by zhongjin on 14-4-10.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
//

#import "UIImage+Conversion.h"
#import "ConverUtil.h"
@implementation UIImage (Conversion)
//3张图片的合成
//图片的合成
+(UIImage *)addImage1:(UIImage *)image1 withImage:(UIImage *)image2 withImage1:(UIImage *)image3   rect1:(CGRect)rect1 rect2:(CGRect)rect2  rect3:(CGRect )rect3 {
    CGSize size = CGSizeMake(rect1.size.width+rect2.size.width+rect3.size.width, rect1.size.height);
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:rect1];
    [image2 drawInRect:rect2];
    [image3 drawInRect:rect3];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

//图片的合成
+(UIImage *)addImage:(UIImage *)image1 withImage:(UIImage *)image2    rect1:(CGRect)rect1 rect2:(CGRect)rect2  {
    CGSize size = CGSizeMake(rect1.size.width+rect2.size.width, rect1.size.height);
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:rect1];
    [image2 drawInRect:rect2];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

/**
 * 修改图片大小
 */
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}


/*
 hexString转换成图片
 */
+(UIImage *)imageWithHextring:(NSString *)HexString
{
    NSData *imgData=[ConverUtil parseHexToByteArray:HexString];
    UIImage *image=[UIImage imageWithData:imgData];
    return image;
}

// 图片裁剪
-(UIImage *)imageAtRect:(CGRect)rect
{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    
    return subImage;
    
}
//绘制图片的大小
+(UIImage *)shrinkImage:(UIImage *)pImage withSize:(CGSize)pSize
{
    UIGraphicsBeginImageContext(pSize);
    
    [pImage drawInRect:CGRectMake(0, 0, pSize.width, pSize.height)];
    
    UIImage *lImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return lImage;
}

//合成虚线
+(UIImage *)CompoundLineImage;
{
    UIImage *imagiaryImage=[UIImage imageNamed:@"bg_imaginaryline.png"];
    CGRect rect;
    CGSize size = CGSizeMake(320, 1);
    UIGraphicsBeginImageContext(size);
    for (int i=0; i<8; i++) {
        rect=CGRectMake(i*40, 0, 40, 1);
        [imagiaryImage drawAsPatternInRect:rect];
    }
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
@end
