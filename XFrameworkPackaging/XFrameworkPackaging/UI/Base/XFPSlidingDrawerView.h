//
//  XFPSlidingDrawerView.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFPSlidingDrawerView : UIView
@property (strong, nonatomic) UIViewController *containerVc;
- (void)addToVC:(UIViewController *)vc;
- (void)show;
- (void)dismiss;
@end
