//
//  LHConfirmAlertView.h
//  SchoolPalmUser
//
//  Created by zhax001 on 14-10-13.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
//

#import "LHBSAlertView.h"

@interface LHConfirmAlertView : LHBSAlertView
- (void)showWithNotice:(NSString *)notice
            sureAction:(void(^)(void))sureAction
          cancelAction:(void(^)(void))cancelAction;
@end
