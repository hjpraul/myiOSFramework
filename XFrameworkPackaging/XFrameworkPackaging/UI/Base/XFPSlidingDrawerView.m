//
//  LHSlidingDrawerView.m
//  CHLightHandle
//
//  Created by hjpraul on 15/3/3.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "LHSlidingDrawerView.h"

@interface LHSlidingDrawerView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceConst;
@end

@implementation LHSlidingDrawerView

- (void)addToVC:(UIViewController *)vc{
    self.containerVc = vc;
    if (![vc.view.subviews containsObject:self]) {
        [vc.view addSubview:self];
        self.frame = vc.view.bounds;
    }
    [vc.view bringSubviewToFront:self];
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.bottomSpaceConst.constant = -HEIGHT(self.contentView);
    self.contentView.center = CGPointMake(WIDTH(self)/2, HEIGHT(self)+HEIGHT(_contentView)/2);

}

- (void)show{
    [self bringSubviewToFront:self];
    self.hidden = NO;
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
//        self.bottomSpaceConst.constant = 0;
        self.contentView.center = CGPointMake(WIDTH(self)/2, HEIGHT(self)-HEIGHT(_contentView)/2);
    } completion:nil];
}

- (void)dismiss{
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
        self.contentView.center = CGPointMake(WIDTH(self)/2, HEIGHT(self)+HEIGHT(_contentView)/2);
//        self.bottomSpaceConst.constant = -HEIGHT(self);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

@end
