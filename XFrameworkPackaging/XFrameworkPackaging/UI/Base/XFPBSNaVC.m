//
//  XFPBSNaVC.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/17.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPBSNaVC.h"
#import <QuartzCore/QuartzCore.h>

@interface XFPBSNaVC ()
@property (nonatomic,strong) UIView *blackMask;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIImageView *lastScreenShotView;
@property (nonatomic,strong) NSMutableArray *screenShotsList;
@property (nonatomic,strong) UIPanGestureRecognizer *panGesture;
@property (assign, nonatomic) CGPoint startPoint;
@property (nonatomic,assign) BOOL isMoving;
@end

@implementation XFPBSNaVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                             action:@selector(paningGestureReceive:)];
    [_panGesture delaysTouchesBegan];
    self.screenShotsList = [NSMutableArray array];
}

- (void)dealloc
{
    self.screenShotsList = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotsList addObject:[self capture]];
    
    UIViewController *currentVC = self.visibleViewController;
    currentVC.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    if (currentVC == self.viewControllers.firstObject) {
        currentVC.hidesBottomBarWhenPushed = NO;
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsList removeLastObject];
    return [super popViewControllerAnimated:animated];
}

#pragma mark - Private Method
- (void)setCanDragBack:(BOOL)canDragBack{
    _canDragBack = canDragBack;
    if (_canDragBack) {
        if (![self.view.gestureRecognizers containsObject:_panGesture]) {
            [self.view addGestureRecognizer:_panGesture];
        }
    } else {
        [self.view removeGestureRecognizer:_panGesture];
    }
}

- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)moveViewWithX:(float)x
{
    x = x>Main_Screen_Width ? Main_Screen_Width : x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);
    
    _lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    _blackMask.alpha = alpha;
    
}

#pragma mark - Gesture Recognizer
- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    if (self.viewControllers.count <= 1 || !self.canDragBack) {
        return;
    }
    
    CGPoint touchPoint = [recoginzer locationInView:[[UIApplication sharedApplication]keyWindow]];
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        [self.view endEditing:YES];
        self.isMoving = YES;
        self.startPoint = touchPoint;
        
        if (!self.backgroundView)
        {
            self.backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            self.blackMask = [[UIView alloc]initWithFrame:self.view.bounds];
            self.blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:_blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (_lastScreenShotView) {
            [_lastScreenShotView removeFromSuperview];
        }
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        _lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        [self.backgroundView insertSubview:_lastScreenShotView belowSubview:_blackMask];
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        if (touchPoint.x - _startPoint.x > 50) {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:Main_Screen_Width];
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                _isMoving = NO;
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - _startPoint.x];
    }
}
@end
