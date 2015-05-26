//
//  XTViewController+Loading.m
//  ZrtCRM
//
//  Created by hjpraul on 13-5-24.
//  Copyright (c) 2014年 ZRT. All rights reserved.
//

#import "UIViewController+Loading.h"
#import "XFPHerLoadingView.h"
#import "XFPVerLoadingView.h"

#define XFP_LOADING_IS_VERTICAL NO

@implementation UIViewController (Loading)

/**********************************************************************/
#pragma mark - Public Methods
/**********************************************************************/
- (void)showLoadingWithMessage:(NSString *)message{
    if (XFP_LOADING_IS_VERTICAL) {
        [XFPVerLoadingView showLoadingMessage:message inView:self.view];
    } else {
        [XFPHerLoadingView showLoadingMessage:message inView:self.view];
    }
}

- (void)showSuccessWithMessage:(NSString *)message{
    if (XFP_LOADING_IS_VERTICAL) {
        [XFPHerLoadingView showSuccessMessage:message inView:self.view];
    } else {
        [XFPHerLoadingView showSuccessMessage:message inView:self.view];
    }
}

- (void)showFailedWithMessage:(NSString *)message{
    if (XFP_LOADING_IS_VERTICAL) {
        [XFPVerLoadingView showFailedMessage:message inView:self.view];
    } else {
        [XFPHerLoadingView showFailedMessage:message inView:self.view];
    }
}

- (void)hideLoading{
    if (XFP_LOADING_IS_VERTICAL) {
        [XFPVerLoadingView hideInView:self.view animated:YES];
    } else {
        [XFPHerLoadingView hideInView:self.view animated:YES];
    }
}
@end
