//
//  LHSlidingDrawerView.h
//  CHLightHandle
//
//  Created by hjpraul on 15/3/3.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHSlidingDrawerView : UIView
@property (strong, nonatomic) UIViewController *containerVc;
- (void)addToVC:(UIViewController *)vc;
- (void)show;
- (void)dismiss;
@end
