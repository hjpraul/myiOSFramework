//
//  NSString+Formate.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "NSString+Formate.h"

@implementation NSString (Formate)
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


-(NSString *)toPurePhoneNum {
    NSString *telString = self;
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
- (NSString *)toSecBankCardNum{
    if (self.length < 12) {
        return nil;
    }else{
        return [NSString stringWithFormat:@"%@ **** **** **** %@",[self substringToIndex:4],[self substringFromIndex:self.length - 4]];
    }
}

// 普通字符串转换为银行卡完整形式，eg:6226222222222222222转换为6226 2222 2222 2222 222
-(NSString *)toBankNum{
    NSString *tmpStr = [self bankCardNumToNormal];
    
    int size = (int)(tmpStr.length/4);
    
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

// 银行卡完整形式转换为普通字符串，eg:6226 2222 2222 2222 222转换为6226222222222222222
- (NSString *)bankCardNumToNormal{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)toFullDateShow {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [dateFormatter dateFromString:self];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *retStr = [dateFormatter stringFromDate:date];
    return retStr;
}

@end
