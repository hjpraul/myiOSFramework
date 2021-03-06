//
//  XFPBSAlertView.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPBSAlertView.h"
#import <QuartzCore/QuartzCore.h>

typedef void (^AnimationBlock)();
typedef void (^AnimationCompletionBlock)(BOOL);

@interface XFPBSAlertView()
@property (nonatomic, retain) UIImageView *dimImageView;
@end

@implementation XFPBSAlertView

- (id)init{
    self = [super init];
    if (self) {
        [self initAlert];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAlert];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initAlert];
    }
    return self;
}

- (void)initAlert{
    // 旋转支持
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [self setPresentationStyle:AlertViewPresentationStyleFade];
    [self setDismissalStyle:AlertViewDismissalStyleFade];
    [self setEnterDirection:AlertViewEnterDirectionFromRight];
    [self setExitDirection:AlertViewExitDirectionToLeft];
}

#pragma mark - Private Method
// 旋转支持
//- (void)deviceOrientationDidChange:(NSNotification *)notification {
//    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
//    
//    CGFloat startRotation = [[self valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
//    CGAffineTransform rotation;
//    
//    switch (interfaceOrientation) {
//        case UIInterfaceOrientationLandscapeLeft:
//            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 270.0 / 180.0);
//            break;
//            
//        case UIInterfaceOrientationLandscapeRight:
//            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 90.0 / 180.0);
//            break;
//            
//        case UIInterfaceOrientationPortraitUpsideDown:
//            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 180.0 / 180.0);
//            break;
//            
//        default:
//            rotation = CGAffineTransformMakeRotation(-startRotation + 0.0);
//            break;
//    }
//    [self setTransform:rotation];
//    [_dimImageView setTransform:rotation];
//}

- (void)performPresentationAnimation{
    switch (self.presentationStyle) {
        case AlertViewPresentationStyleNone:{
            
        }break;
        case AlertViewPresentationStylePop:{
            CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
            bounceAnimation.duration = 0.3f;
            bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            bounceAnimation.values = @[@0.01f,@1.1f,@0.9f,@1.0f];
            [self.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
            
            CABasicAnimation *fadeInAnimation = [CABasicAnimation animation];
            fadeInAnimation.duration = 0.3f;
            fadeInAnimation.fromValue = @0.0f;
            fadeInAnimation.toValue = @1.0f;
            [self.dimImageView.layer addAnimation:fadeInAnimation forKey:@"opacity"];
        }break;
        case AlertViewPresentationStyleFade:{
            [self setAlpha:0.0f];
            [self.dimImageView setAlpha:0.0f];
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setAlpha:1.0f];
                [self.dimImageView setAlpha:1.0f];
            } completion:nil];
        }break;
        case AlertViewPresentationStylePush:{
            CGPoint center = self.center;
            [self setCenter:[self enterCenterForDirection:self.enterDirection]];
            [self.dimImageView setAlpha:0.0f];
            [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setCenter:center];
                [self.dimImageView setAlpha:1.0f];
            } completion:nil];
        }break;
        default:break;
    }
}

- (void)performDismissalAnimation{
    
    AnimationCompletionBlock completionBlock = ^(BOOL finished){
        [self.dimImageView removeFromSuperview];
        [self removeFromSuperview];
    };
    
    switch (self.dismissalStyle) {
        case AlertViewDismissalStyleNone:{
            completionBlock(YES);
        }break;
        case AlertViewDismissalStyleZoomIn:{
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self setTransform:CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(0.01, 0.01))];
                [self setAlpha:0.0f];
                [self.dimImageView setAlpha:0.0f];
            } completion:completionBlock];
        }break;
        case AlertViewDismissalStyleZoomOut:{
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self setTransform:CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(10, 10))];
                [self setAlpha:0.0f];
                [self.dimImageView setAlpha:0.0f];
            } completion:completionBlock];
        }break;
        case AlertViewDismissalStyleFade:{
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setAlpha:0.0f];
                [self.dimImageView setAlpha:0.0f];
            } completion:completionBlock];
        }break;
        case AlertViewDismissalStylePush:{
            [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setCenter:[self enterCenterForDirection:self.enterDirection]];
                [self.dimImageView setAlpha:0.0f];
            } completion:completionBlock];
        }break;
    }
}

- (CGPoint)enterCenterForDirection:(AlertViewEnterDirection)direction{
    CGPoint center = CGPointMake(self.superview.bounds.size.width/2, self.superview.bounds.size.height/2);
	switch(direction) {
		case AlertViewEnterDirectionFromTop:
            center.y = -self.bounds.size.height;
		case AlertViewEnterDirectionFromRight:
            center.x = self.bounds.size.width+self.superview.bounds.size.width;
		case AlertViewEnterDirectionFromBottom:
            center.x = self.bounds.size.height+self.superview.bounds.size.height;
		case AlertViewEnterDirectionFromLeft:
            center.y = -self.bounds.size.width;
	}
	return center;
}

- (CGPoint)exitCenterForDirection:(AlertViewExitDirection)direction{
    CGPoint center = CGPointMake(self.superview.bounds.size.width/2, self.superview.bounds.size.height/2);
	switch(direction) {
		case AlertViewExitDirectionToTop:
            center.y = -self.bounds.size.height;
		case AlertViewExitDirectionToRight:
            center.x = self.bounds.size.width+self.superview.bounds.size.width;
		case AlertViewExitDirectionToBottom:
            center.x = self.bounds.size.height+self.superview.bounds.size.height;
		case AlertViewExitDirectionToLeft:
            center.y = -self.bounds.size.width;
	}
	return center;
}

// 点旁边dismiss
- (void)imgBgTapped:(UITapGestureRecognizer *)sender{
    if (_enableClickBGToDismiss) {
        [self dismiss];
    }
}

#pragma mark - Public Method

- (void)show{
    [self showWithStyle:self.presentationStyle];
}

- (void)showWithStyle:(AlertViewPresentationStyle)presentationStyle{
    [self setPresentationStyle:presentationStyle];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    //设置遮罩背景
    UIImage *bgImage = [UIImage imageWithColor:[UIColor colorWithWhite:0 alpha:0.5] size:bounds.size];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:bounds];
    [imageView setUserInteractionEnabled:YES];
    [imageView setImage:bgImage];
    self.dimImageView = imageView;
    [[UIApplication sharedApplication].windows.firstObject addSubview:_dimImageView];
    
    // 增加点击背景关闭的手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgBgTapped:)];
    [imageView addGestureRecognizer:gesture];
    
    //设置提示弹框
    [self setCenter:CGPointMake(bounds.size.width/2, bounds.size.height/2)];
	[[UIApplication sharedApplication].windows.firstObject addSubview:self];
    
	//出入场动画
	[self performPresentationAnimation];
}

- (void)dismiss{
    BLOCK_SAFE(_dismissBlock)();
    [self dismissWithStyle:self.dismissalStyle];
}
- (void)dismissWithStyle:(AlertViewDismissalStyle)dismissalStyle{
    [self setDismissalStyle:dismissalStyle];
    
    //隐藏键盘
	[self endEditing:YES];
    
	//出场动画
	[self performDismissalAnimation];
}

//#pragma mark - UIKeyboardNotification
//- (void)keyboardWillShow:(CGRect)frame duration:(NSTimeInterval)duration{
//    CGPoint center = self.center;
//    center.y = self.superview.bounds.size.height-(frame.size.height+self.bounds.size.height/2+20);
//    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
//        [self setCenter:center];
//    } completion:nil];
//}
//
//- (void)keyboardWillHide:(CGRect)frame duration:(NSTimeInterval)duration{
//    CGPoint center = CGPointMake(self.superview.bounds.size.width/2, self.superview.bounds.size.height/2);
//    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
//        [self setCenter:center];
//    } completion:nil];
//}
//
//- (void)keyboardWillChangeFrame:(CGRect)frame duration:(NSTimeInterval)duration{
//    CGPoint center = self.center;
//    center.y = self.superview.bounds.size.height-(frame.size.height+self.bounds.size.height/2+20);
//    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
//        [self setCenter:center];
//    } completion:nil];
//}

@end
