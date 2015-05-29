//
//  XFPBGHerLoadingView.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//


@interface XFPBGHerLoadingView : UIView

+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view;
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view;
+ (void)showNoInfoMessage:(NSString *)message inView:(UIView *)view;

+ (void)hideInView:(UIView *)view animated:(BOOL)animated;

@end
