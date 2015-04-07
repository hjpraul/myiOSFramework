//
//  NSString+Formate.m
//  UnionSYF
//
//  Created by hjpraul on 14-4-23.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
//

#import "NSString+Formate.h"

@implementation NSString (Formate)

- (NSString *)getFormatedDateAndTime{
    if (self.length < 14) {
        return nil;
    }
    
    NSMutableString *tempString = [NSMutableString string];
    [tempString appendString:[self substringToIndex:4]];    // yyyy
    for (int i = 0; i < 5; i++) {   // MMddhhssmm
        if (i < 2) {
            [tempString appendString:@"-"];
        } else if (i == 2) {
            [tempString appendString:@" "];
        } else {
            [tempString appendString:@":"];
        }
        NSRange range = {4+i*2,2};
        [tempString appendString:[self substringWithRange:range]];
    }
    return [NSString stringWithString:tempString];
}

- (NSString *)getFormatedAmount{
    return [NSString stringWithFormat:@"%.2f",self.floatValue/100];
}

- (NSString *)getUnFormatedAmount{
//    NSRange range=[self rangeOfString:@"."];
//    if (range.location==[self length]-3) {
//       
//    }
//    else if(range.location==[self length]-2)
//    {
//        return [NSString stringWithFormat:@"%d",(NSInteger)(self.floatValue*10)];
//    }
//    else if (range.location==[self length]-1)
//    {
//        return [self substringToIndex:self.length-1];
//    }
//    return self;
     return [NSString stringWithFormat:@"%d",(NSInteger)(self.floatValue*100)];
}



+ (NSAttributedString *)getFormatedAmountWithColor:(UIColor *)textColor
                                            amount:(NSString *)amount
                                              unit:(NSString *)unit{
    if (amount == nil) {
        amount = @"0";
    }
    if (unit == nil) {
        unit = @"";
    }
//    amount=[NSString stringWithFormat:@"%.2lf",[amount floatValue]/100];
    NSString *str = [NSString stringWithFormat:@"%@%@",amount,unit];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:24.0f]
                    range:NSMakeRange(0, amount.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(amount.length, unit.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:textColor
                    range:NSMakeRange(0, str.length)];
    
    return [[NSAttributedString alloc] initWithAttributedString:attrStr];
    
//    NSString *realAmount = [amount getFormatedAmount];
//    NSString *str = [NSString stringWithFormat:@"%@%@%@%@",title,[realAmount substringToIndex:realAmount.length-3],[realAmount substringFromIndex:realAmount.length-3],unit];
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
//    
//    [attrStr addAttribute:NSFontAttributeName
//                    value:[UIFont systemFontOfSize:14.0f]
//                    range:NSMakeRange(0, title.length)];
//    
//    [attrStr addAttribute:NSFontAttributeName
//                    value:[UIFont systemFontOfSize:26.0f]
//                    range:NSMakeRange(title.length, realAmount.length-3)];
//    
//    [attrStr addAttribute:NSFontAttributeName
//                    value:[UIFont systemFontOfSize:14.0f]
//                    range:NSMakeRange(title.length+realAmount.length-3, 3+unit.length)];
//    
//    return [[NSAttributedString alloc] initWithAttributedString:attrStr];
}


+(NSString *)ReplaceSpecialCharacter:(NSString *)replaceString
{
    NSString *telString=replaceString;
    NSRange range;
    while ((range=[telString rangeOfString:@"mobile:" options:NSRegularExpressionSearch]).location!=NSNotFound) {
        telString=[telString stringByReplacingCharactersInRange:range withString:@""];
    }
    while ((range=[telString rangeOfString:@"home:" options:NSRegularExpressionSearch]).location!=NSNotFound) {
        telString=[telString stringByReplacingCharactersInRange:range withString:@""];
    }
    while ((range=[telString rangeOfString:@"-" options:NSRegularExpressionSearch]).location!=NSNotFound) {
        telString=[telString stringByReplacingCharactersInRange:range withString:@""];
    }
    while ((range=[telString rangeOfString:@"+86" options:NSRegularExpressionSearch]).location!=NSNotFound) {
        telString=[telString stringByReplacingCharactersInRange:range withString:@""];
    }
    return telString;
}

// 普通字符串转换为银行卡安全形式 eg:6226222222222222222转换为6226 **** **** **** 2222
- (NSString *)normalToSecBankCardNum{
    if (self.length < 12) {
        return nil;
    }else{
        return [NSString stringWithFormat:@"%@ **** **** **** %@",[self substringToIndex:4],[self substringFromIndex:self.length - 4]];
    }
}

// 银行卡完整形式转换为普通字符串，eg:6226 2222 2222 2222 222转换为6226222222222222222
- (NSString *)bankCardNumTONormal{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

// 普通字符串转换为银行卡完整形式，eg:6226222222222222222转换为6226 2222 2222 2222 222
-(NSString *)normalToBankNum{
    NSString *tmpStr = [self bankCardNumTONormal];
    
    int size = (tmpStr.length / 4);
    
    NSMutableArray *tmpStrArr = [NSMutableArray array];
    for (int n = 0;n < size; n++)
    {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    
    [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size*4, (tmpStr.length % 4))]];
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    
    // 去掉末尾的" "
    if ([tmpStr hasSuffix:@" "]) {
        return [tmpStr substringToIndex:tmpStr.length - 1];
    }else{
        return tmpStr;
    }
}
//今天是2014-6-10，有没有接口计算添加两个月的日期是多少
+(NSDate *)dateWithIntervalMonthFromDate_Ext:(NSDate *)date intervalMonth:(NSInteger)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

@end
