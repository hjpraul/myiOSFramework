//
//  NSDate+Operation.m
//  SchoolPalmAgent
//
//  Created by zhax001 on 14-9-11.
//  Copyright (c) 2014年 zhax. All rights reserved.
//

#import "NSDate+Operation.h"

@implementation NSDate (Formate)
- (NSDate *)offsetDay:(NSInteger)offset{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:+offset];
    return [calendar dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)offsetMonth:(NSInteger)offset{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:+offset];
    [adcomps setDay:0];
    return [calendar dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)offsetYear:(NSInteger)offset{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:+offset];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    return [calendar dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)setDay:(NSInteger)day{
    if ((day < 1) || (day > 31)) {
        return self;
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    [comps setDay:day];
    
    return [calendar dateFromComponents:comps];
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

- (NSDate *)setYear:(NSInteger)year{
    if ((year < 1970) || (year > 10000)) {
        return self;
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    [comps setYear:year];
    
    return [calendar dateFromComponents:comps];
}

@end
