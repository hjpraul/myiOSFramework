//
//  UIView+BGLoading.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/5/27.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "UIView+BGLoading.h"
#import "XFPBGHerLoadingView.h"
#import "XFPBGVerLoadingView.h"

#define XFP_BG_LOADING_IS_VERTICAL YES

@implementation UIView (BGLoading)
- (void)showBGLoadingWithMessage:(NSString *)message{
    if (XFP_BG_LOADING_IS_VERTICAL) {
        [XFPBGVerLoadingView showLoadingMessage:message inView:self];
    } else {
        [XFPBGHerLoadingView showLoadingMessage:message inView:self];
    }
}
- (void)showBGFailedWithMessage:(NSString *)message{
    if (XFP_BG_LOADING_IS_VERTICAL) {
        [XFPBGVerLoadingView showFailedMessage:message inView:self];
    } else {
        [XFPBGHerLoadingView showFailedMessage:message inView:self];
    }
}
- (void)showBGNoInfoWithMessage:(NSString *)message{
    if (XFP_BG_LOADING_IS_VERTICAL) {
        [XFPBGVerLoadingView showNoInfoMessage:message inView:self];
    } else {
        [XFPBGHerLoadingView showNoInfoMessage:message inView:self];
    }
}
- (void)hideBGLoading{
    if (XFP_BG_LOADING_IS_VERTICAL) {
        [XFPBGVerLoadingView hideInView:self animated:NO];
    } else {
        [XFPBGHerLoadingView hideInView:self animated:NO];
    }
}
@end
