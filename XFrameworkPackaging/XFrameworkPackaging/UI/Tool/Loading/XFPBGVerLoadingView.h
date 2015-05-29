//
//  XFPBGVerLoadingView.h
//  Unionpay
//
//  Created by Qing Xiubin on 13-8-1.
//  Copyright (c) 2013年 成都中信联通科技有限公司. All rights reserved.
//


@interface XFPBGVerLoadingView : UIView

+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view;
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view;
+ (void)showNoInfoMessage:(NSString *)message inView:(UIView *)view;

+ (void)hideInView:(UIView *)view animated:(BOOL)animated;

@end
