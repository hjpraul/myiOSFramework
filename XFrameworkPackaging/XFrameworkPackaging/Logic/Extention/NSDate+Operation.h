//
//  NSDate+Formate.h
//  SchoolPalmAgent
//
//  Created by zhax001 on 14-9-11.
//  Copyright (c) 2014年 zhax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formate)
- (NSString *)toUploadYMStart;
- (NSString *)toUploadYMEnd;
- (NSString *)toUploadYMD;
- (NSString *)toUploadYMDHms;
- (NSString *)toFilterY;
- (NSString *)toFilterYM;
- (NSString *)toFilterYMD;
- (NSString *)toFullDate;
- (NSString *)toSendTimeHM;

- (NSDate *)setMonth:(NSInteger)month;
- (NSDate *)offsetMonth:(NSInteger)offset;
- (NSDate *)lastMonth;
- (NSDate *)nextDay;
- (NSDate *)lastDay;
@end
