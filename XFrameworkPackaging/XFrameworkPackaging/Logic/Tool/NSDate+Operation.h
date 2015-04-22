//
//  NSDate+Operation.h
//  SchoolPalmAgent
//
//  Created by zhax001 on 14-9-11.
//  Copyright (c) 2014年 zhax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Operation)
- (NSDate *)offsetDay:(NSInteger)offset;
- (NSDate *)offsetMonth:(NSInteger)offset;
- (NSDate *)offsetYear:(NSInteger)offset;

- (NSDate *)setDay:(NSInteger)day;
- (NSDate *)setMonth:(NSInteger)month;
- (NSDate *)setYear:(NSInteger)year;
@end
