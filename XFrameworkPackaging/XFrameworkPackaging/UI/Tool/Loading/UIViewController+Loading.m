//
//  XTViewController+Loading.m
//  ZrtCRM
//
//  Created by hjpraul on 13-5-24.
//  Copyright (c) 2014年 ZRT. All rights reserved.
//

#import "UIViewController+Loading.h"
#import "XFPHerLoadingView.h"

@implementation UIViewController (Loading)

/**********************************************************************/
#pragma mark - Public Methods
/**********************************************************************/
- (void)showLoadingWithMessage:(NSString *)message{
    [XFPHerLoadingView showLoadingMessage:message inView:self.view];
}

- (void)showSuccessWithMessage:(NSString *)message{
    [XFPHerLoadingView showSuccessMessage:message inView:self.view];
}

- (void)showFailedWithMessage:(NSString *)message{
    [XFPHerLoadingView showFailedMessage:message inView:self.view];
}

- (void)hideLoading{
    [XFPHerLoadingView hideInView:self.view animated:YES];
}
@end
