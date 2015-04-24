//
//  UIImage+Process.m
//  UnionSYF
//
//  Created by zhongjin on 14-4-10.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
//

#import "UIImage+Process.h"
@implementation UIImage (Process)

#pragma mark - Private Method
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


// 图片合成
+(UIImage *)imageCombinedByImage1:(UIImage *)image1 rect1:(CGRect)rect1
                         image2:(UIImage *)image2 rect2:(CGRect)rect2 {
    CGSize size = CGSizeMake(rect1.size.width+rect2.size.width, rect1.size.height);
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:rect1];
    [image2 drawInRect:rect2];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

// 修改图片大小
- (UIImage *)imageScaledToSize:(CGSize)newSize aspectRatio:(BOOL)aspectRatio{
    CGSize realSize = CGSizeZero;
    if (aspectRatio) {
        CGFloat wRatio = newSize.width/self.size.width;
        CGFloat hRatio = newSize.height/self.size.height;
        CGFloat realRatio = (wRatio<hRatio? wRatio : hRatio);
        realSize.width = realRatio*self.size.width;
        realSize.height = realRatio*self.size.height;
    } else {
        realSize = newSize;
    }
    
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor
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

// 图片裁剪
-(UIImage *)subImageAtRect:(CGRect)rect;
{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    
    return subImage;
}

- (UIImage *)toRoundedRectImageWithSize:(CGSize)size radius:(NSInteger)radius
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

- (UIImage *)cropAtRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImageView *imageViewCropped = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:imageRef]];
    [imageViewCropped setFrame:rect];
    
    CGImageRelease(imageRef);
    return imageViewCropped.image;
}
@end
