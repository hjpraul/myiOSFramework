//
//  UIView+Loading.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/22.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "UIView+Loading.h"
#import "XFPHerLoadingView.h"

@implementation UIView (Loading)
- (void)showLoadingWithMessage:(NSString *)message{
    [XFPHerLoadingView showLoadingMessage:message inView:self];
}

- (void)showSuccessWithMessage:(NSString *)message{
    [XFPHerLoadingView showSuccessMessage:message inView:self];
}

- (void)showFailedWithMessage:(NSString *)message{
    [XFPHerLoadingView showFailedMessage:message inView:self];
}

- (void)hideLoading{
    [XFPHerLoadingView hideInView:self animated:YES];
}

@end
