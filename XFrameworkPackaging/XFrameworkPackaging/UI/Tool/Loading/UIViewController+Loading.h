//
//  UIViewController+HUD.h
//  ZrtCRM
//
//  Created by hjpraul on 13-5-24.
//  Copyright (c) 2014年 ZRT. All rights reserved.
//

@interface UIViewController (Loading)

//Loading Methods
- (void)showLoadingWithMessage:(NSString *)message;
- (void)showSuccessWithMessage:(NSString *)message;
- (void)showFailedWithMessage:(NSString *)message;
- (void)hideLoading;

@end
