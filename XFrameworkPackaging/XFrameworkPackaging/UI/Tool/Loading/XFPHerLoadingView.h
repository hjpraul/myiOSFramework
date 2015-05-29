//
//  XFPHerLoadingView.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//


@interface XFPHerLoadingView : UIView

+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view;
+ (void)showSuccessMessage:(NSString *)message inView:(UIView *)view;
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view;

+ (void)hideInView:(UIView *)view animated:(BOOL)animated;

@end
