//
//  XFPConfirmAlertView.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPBSAlertView.h"

@interface XFPConfirmAlertView : XFPBSAlertView
- (void)showWithNotice:(NSString *)notice
            sureAction:(void(^)(void))sureAction
          cancelAction:(void(^)(void))cancelAction;
@end
