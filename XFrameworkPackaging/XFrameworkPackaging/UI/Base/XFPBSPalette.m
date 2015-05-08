//
//  XFPBSPalette.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/5/6.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPBSPalette.h"

#define INDICATOR_SIZE    (6)

@interface XFPBSPalette ()
@property (strong, nonatomic) UIView *indicator;
@end

@implementation XFPBSPalette

#pragma mark - Private Method
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    
    return self;
}

#pragma mark - Private Method
- (void)initView{
    if (!_indicator) {
        _indicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, INDICATOR_SIZE, INDICATOR_SIZE)];
        _indicator.backgroundColor = [UIColor clearColor];
        ViewBorderRadius(_indicator, 1, 1, [UIColor redColor]);
    }
    
    if (_indicator.superview != self) {
        [self addSubview:_indicator];
    }
}

- (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef)inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    

    bitmapBytesPerRow   = (int)(pixelsWide * 4);
    bitmapByteCount     = (int)(bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
    {
        DDLogWarn(@"Error allocating color space\n");
        return NULL;
    }
    
    bitmapData = malloc(bitmapByteCount);
    if (bitmapData == NULL)
    {
        DDLogWarn(@"Memory not allocated!");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }
    
    // 创建bitmapContext ARGB, 8-bits per component
    int bitmapInfo;
    if (isIOS7Above) {
        bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst;
    } else {
        bitmapInfo = kCGImageAlphaPremultipliedLast;
    }
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     bitmapInfo);
    if (context == NULL)
    {
        free (bitmapData);
        DDLogWarn(@"Context not created!");
    }

    // 内存释放
    CGColorSpaceRelease(colorSpace);
    return context;
}

- (UIColor *)getColorAtPoint:(CGPoint)point{
    UIColor* color = nil;
    
    CGImageRef inImage = self.image.CGImage;
    // 通过image创建 bitmap context. 每个pixel的格式：ARGB 长度：4 bytes
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) {
        return nil;
    }
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    // 将图片画进 bitmap context
    CGContextDrawImage(cgctx, rect, inImage);
    
    // 获取bitmap数据
    unsigned char* data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        // 通过X、Y计算对应数据在data中的offset
        // 注意：这里一定要乘以scale
        @try {
//            DDLogInfo(@"[[UIScreen mainScreen] scale]:%f",self.bounds.size.height);
            int offset = 4*((w*round(point.y*[[UIScreen mainScreen] scale]))+round(point.x*[[UIScreen mainScreen] scale]));
            int alpha =  data[offset];
            int red = data[offset+1];
            int green = data[offset+2];
            int blue = data[offset+3];
            DDLogInfo(@"offset: %i colors: ARGB %i %i %i  %i",offset,alpha,red,green,blue);
            color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
        }
        @catch (NSException * e) {
            DDLogError(@"%@",[e reason]);
        }
        @finally {
        }
        
    }
    
    // 内存释放
    CGContextRelease(cgctx);
    if (data) {
        free(data);
    }
    
    return color;
}

#pragma mark - touch responder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint nowPoint = [touch locationInView:self];
    
    if (nowPoint.x+INDICATOR_SIZE/2 > WIDTH(self)) {
        return;
    } else if (nowPoint.x-INDICATOR_SIZE/2 < 0) {
        return;
    } else if (nowPoint.y+INDICATOR_SIZE/2 > HEIGHT(self)) {
        return;
    } else if (nowPoint.y-INDICATOR_SIZE/2 < 0) {
        return;
    } else {
        _indicator.center = nowPoint;
        _selectedColor = [self getColorAtPoint:nowPoint];
        BLOCK_SAFE(_selectedColorChangedBlock)(_selectedColor);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint nowPoint = [touch locationInView:self];
    
    if (nowPoint.x+INDICATOR_SIZE/2 > WIDTH(self)) {
        return;
    } else if (nowPoint.x-INDICATOR_SIZE/2 < 0) {
        return;
    } else if (nowPoint.y+INDICATOR_SIZE/2 > HEIGHT(self)) {
        return;
    } else if (nowPoint.y-INDICATOR_SIZE/2 < 0) {
        return;
    } else {
        _indicator.center = nowPoint;
        _selectedColor = [self getColorAtPoint:nowPoint];
        BLOCK_SAFE(_selectedColorChangedBlock)(_selectedColor);
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

#pragma mark - Public Method
- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    
    CGImageRef inImage = self.image.CGImage;
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) { return;  }
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    CGContextDrawImage(cgctx, rect, inImage);
    
    unsigned char* data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < w; x++) {
                int offset = (int)(4*((w*y)+x));
                int alpha =  data[offset];
                int red = data[offset+1];
                int green = data[offset+2];
                int blue = data[offset+3];
                CIColor *ciColor = [CIColor colorWithCGColor:selectedColor.CGColor];
                if ((ciColor.alpha*255 == alpha) &&
                    (ciColor.red*255 == red) &&
                    (ciColor.green*255 == green) &&
                    (ciColor.blue*255 == blue)) {
                    DDLogInfo(@"selected success[offset:%zd,%zd,%zd]",offset,x,y);
                    _indicator.center = CGPointMake(x, y);
                    BLOCK_SAFE(_selectedColorChangedBlock)(_selectedColor);
                    break;
                }
            }
        }
    }
    
    // 内存释放
    CGContextRelease(cgctx);
    if (data) {
        free(data);
    }
}
@end
