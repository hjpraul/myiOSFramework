//
//  NSDate+Operation.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
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
