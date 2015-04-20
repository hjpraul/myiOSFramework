//
//  UIViewController+HUD.h
//  ZrtCRM
//
//  Created by hjpraul on 13-5-24.
//  Copyright (c) 2014年 ZRT. All rights reserved.
//

@interface UIViewController (HUD)

//HUD Methods
- (void)showLoadingWithMessage:(NSString *)message;
- (void)showSuccessWithMessage:(NSString *)message;
- (void)showFailedWithMessage:(NSString *)message;
- (void)hideLoading;

//HUD Methods
- (void)showBGLoadingWithMessage:(NSString *)message;
- (void)showBGLoadFailedWithMessage:(NSString *)message;
- (void)showBGLoadEmptyWithMessage:(NSString *)message;
- (void)hideBGLoading;

@end
