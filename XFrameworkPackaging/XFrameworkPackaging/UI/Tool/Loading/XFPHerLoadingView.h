//
//  XFPHerLoadingView.h
//  SchoolPalmUser
//
//  Created by hjpraul on 14-8-5.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
//


@interface XFPHerLoadingView : UIView

+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view;
+ (void)showSuccessMessage:(NSString *)message inView:(UIView *)view;
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view;

+ (void)hideInView:(UIView *)view animated:(BOOL)animated;

@end
