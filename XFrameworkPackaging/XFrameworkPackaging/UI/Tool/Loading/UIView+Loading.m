//
//  UIView+Loading.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/22.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "UIView+Loading.h"
#import "XFPHerLoadingView.h"
#import "XFPVerLoadingView.h"

#define XFP_LOADING_IS_VERTICAL YES

@implementation UIView (Loading)
- (void)showLoadingWithMessage:(NSString *)message{
    if (XFP_LOADING_IS_VERTICAL) {
        [XFPVerLoadingView showLoadingMessage:message inView:self];
    } else {
        [XFPHerLoadingView showLoadingMessage:message inView:self];
    }
}

- (void)showSuccessWithMessage:(NSString *)message{
    if (XFP_LOADING_IS_VERTICAL) {
        [XFPVerLoadingView showSuccessMessage:message inView:self];
    } else {
        [XFPHerLoadingView showSuccessMessage:message inView:self];
    }
}

- (void)showFailedWithMessage:(NSString *)message{
    if (XFP_LOADING_IS_VERTICAL) {
        [XFPVerLoadingView showFailedMessage:message inView:self];
    } else {
        [XFPHerLoadingView showFailedMessage:message inView:self];
    }
}

- (void)hideLoading{
    if (XFP_LOADING_IS_VERTICAL) {
        [XFPVerLoadingView hideInView:self animated:YES];
    } else {
        [XFPHerLoadingView hideInView:self animated:YES];
    }
}

@end
