//
//  LHBSButton.m
//  CHLightHandle
//
//  Created by hjpraul on 15/1/26.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "LHBSButton.h"
#import "UIImage+Create.h"

@implementation LHBSButton
#pragma mark - Private Method
- (void)setNormalBgColor:(UIColor *)color{
    UIImage *bgImg = [[UIImage imageWithColor:color size:self.frame.size] roundedRectImageWithSize:self.frame.size radius:LH_BS_BUTTON_RADIUS];
    [self setBackgroundImage:bgImg forState:UIControlStateNormal];
//    CGFloat red;
//    CGFloat green;
//    CGFloat blue;
//    CGFloat alpha;
//    [color getRed:&red green:&green blue:&blue alpha:&alpha];
//    if ((alpha < 1) && !(red && green && blue)) {
//        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:alpha+0.1] size:self.frame.size] forState:UIControlStateHighlighted];
//    }
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        ViewBorderRadius(self, LH_BS_BUTTON_RADIUS, 2, [UIColor yellowColor]);
    } else {
        ViewBorderRadius(self, LH_BS_BUTTON_RADIUS, 0, [UIColor clearColor]);
    }
}

#pragma mark - Public Method
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [self performSelector:@selector(setNormalBgColor:) withObject:backgroundColor afterDelay:0.0f];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    UIImage *bgImg = [[UIImage imageWithColor:backgroundColor size:self.frame.size] roundedRectImageWithSize:self.frame.size radius:3.0];
    [self setBackgroundImage:bgImg forState:state];
}

@end
