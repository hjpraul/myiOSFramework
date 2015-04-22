//
//  NSString+Toast.m
//  BankHallManagement
//
//  Created by hjpraul on 15/2/4.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "NSString+Toast.h"
#import "TKAlertCenter.h"

@implementation NSString (Toast)
- (void)toast{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:self];
}
@end
