//
//  XFPIncDecSlider.m
//  MobileCRM
//
//  Created by hjpraul on 12/3/14.
//  Copyright (c) 2014 hjpraul. All rights reserved.
//

#import "XFPIncDecSlider.h"

@interface XFPIncDecSlider ()
@property (assign, nonatomic) CGPoint beginPoint;
@property (weak, nonatomic) IBOutlet UIImageView *moveDot;
@property (weak, nonatomic) IBOutlet UIImageView *sliderFramBg;
@end

@implementation XFPIncDecSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];

    CGPoint beganPoint = [touch locationInView:self];
    if (CGRectContainsPoint(_moveDot.frame, beganPoint)) {
        self.beginPoint = beganPoint;
    } else {
        self.beginPoint = CGPointZero;
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint nowPoint = [touch locationInView:self];
    
    if (CGPointEqualToPoint(self.beginPoint, CGPointZero)) {
        if (CGRectContainsPoint(_moveDot.frame, nowPoint)) {
            self.beginPoint = nowPoint;
        }
    } else {
        CGFloat centerX;
        if (nowPoint.x > X(_sliderFramBg)+WIDTH(_sliderFramBg)-WIDTH(_moveDot)/2){
            centerX = X(_sliderFramBg)+WIDTH(_sliderFramBg)-WIDTH(_moveDot)/2;
        } else if (nowPoint.x < X(_sliderFramBg)+WIDTH(_moveDot)/2) {
            centerX = X(_sliderFramBg)+WIDTH(_moveDot)/2;
        } else {
            centerX = nowPoint.x;
        }
        _moveDot.center = CGPointMake(centerX, _moveDot.center.y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint nowPoint = [touch locationInView:self];
    float offsetX = nowPoint.x - WIDTH(self)/2;
    ///TODO:移到原位
    if (offsetX > 30) {///TODO:过半
        BLOCK_SAFE(_incAction)();
    } else if (offsetX < 30) {
        BLOCK_SAFE(_decAction)();
    }
    _moveDot.center = _sliderFramBg.center;
}

@end
