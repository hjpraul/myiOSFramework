//
//  UIView+BGLoading.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/5/27.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "UIView+BGLoading.h"
#import "XFPBGLoadingView.h"

@implementation UIView (BGLoading)
- (void)showBGLoadingWithMessage:(NSString *)message{
    [XFPBGLoadingView showLoadingMessage:message inView:self];
}
- (void)showBGFailedWithMessage:(NSString *)message{
    [XFPBGLoadingView showFailedMessage:message inView:self];
}
- (void)showBGNoInfoWithMessage:(NSString *)message{
    [XFPBGLoadingView showNoInfoMessage:message inView:self];
}
- (void)hideBGLoading{
    [XFPBGLoadingView hideInView:self animated:NO];
}
@end
