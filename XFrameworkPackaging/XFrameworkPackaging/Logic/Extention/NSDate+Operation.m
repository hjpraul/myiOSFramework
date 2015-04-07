//
//  NSDate+Formate.m
//  SchoolPalmAgent
//
//  Created by zhax001 on 14-9-11.
//  Copyright (c) 2014年 zhax. All rights reserved.
//

#import "NSDate+Formate.h"

@implementation NSDate (Formate)
- (NSString *)toUploadYMStart{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMM01";
    return [dateFormatter stringFromDate:self];
}

- (NSString *)toUploadYMEnd{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMM";
    NSString *tempStr = [dateFormatter stringFromDate:self];
    NSInteger mounth = [[tempStr substringFromIndex:4] integerValue];
    if (mounth == 2) {
        NSInteger year = [[tempStr substringToIndex:4] integerValue];
        if ((year%4 == 0) && (year%100 != 0)) {
            return [NSString stringWithFormat:@"%@29",tempStr];
        } else {
            return [NSString stringWithFormat:@"%@28",tempStr];
        }
    } else if (mounth < 7){
        if (mounth % 2) {
            return [NSString stringWithFormat:@"%@31",tempStr];
        } else {
            return [NSString stringWithFormat:@"%@30",tempStr];
        }
    } else {
        if (mounth % 2) {
            return [NSString stringWithFormat:@"%@30",tempStr];
        } else {
            return [NSString stringWithFormat:@"%@31",tempStr];
        }
    }
}

- (NSString *)toUploadYMD{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    return [dateFormatter stringFromDate:self];
}

- (NSString *)toUploadYMDHms{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    return [dateFormatter stringFromDate:self];
}

- (NSString *)toFilterY{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年";
    return [dateFormatter stringFromDate:self];
}
- (NSString *)toFilterYM{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月";
    return [dateFormatter stringFromDate:self];
}
- (NSString *)toFilterYMD{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日";
    return [dateFormatter stringFromDate:self];
}

- (NSString *)toFullDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter stringFromDate:self];
}

- (NSString *)toSendTimeHM{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    return [dateFormatter stringFromDate:self];
}

- (NSDate *)setMonth:(NSInteger)month{
    if ((month < 1) || (month > 12)) {
        return self;
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    [comps setMonth:month];
    
    return [calendar dateFromComponents:comps];
}

- (NSDate *)offsetMonth:(NSInteger)offset{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comps = nil;
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:+offset];
    [adcomps setDay:0];
    return [calendar dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)lastMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comps = nil;
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-1];
    [adcomps setDay:0];
    return [calendar dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)nextDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comps = nil;
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:+1];
    return [calendar dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)lastDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comps = nil;
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:-1];
    return [calendar dateByAddingComponents:adcomps toDate:self options:0];
}
@end
