//
//  UIView+BGLoading.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/5/27.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BGLoading)
- (void)showBGLoadingWithMessage:(NSString *)message;
- (void)showBGFailedWithMessage:(NSString *)message;
- (void)showBGNoInfoWithMessage:(NSString *)message;
- (void)hideBGLoading;
@end
