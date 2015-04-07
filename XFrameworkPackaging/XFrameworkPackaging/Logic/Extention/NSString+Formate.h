//
//  NSString+Formate.h
//  UnionSYF
//
//  Created by hjpraul on 14-4-23.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Formate)

// 格式化时间字符串
- (NSString *)getFormatedDateAndTime;

// 格式化金额字符串
- (NSString *)getFormatedAmount;

// 获得格式化前的金额字符串
- (NSString *)getUnFormatedAmount;

// 获取格式化金额字符串（字体大小）
+ (NSAttributedString *)getFormatedAmountWithColor:(UIColor *)textColor
                                            amount:(NSString *)amount
                                              unit:(NSString *)unit;
//替换掉电话中某些特殊的字符
+(NSString *)ReplaceSpecialCharacter:(NSString *)replaceString;

// 普通字符串转换为银行卡安全形式 eg:6226222222222222222转换为6226 **** **** **** 2222
- (NSString *)normalToSecBankCardNum;

// 普通字符串转换为银行卡完整形式，eg:6226222222222222222转换为6226 2222 2222 2222 222
-(NSString *)normalToBankNum;

// 银行卡完整形式转换为普通字符串，eg:6226 2222 2222 2222 222转换为6226222222222222222
- (NSString *)bankCardNumTONormal;

@end
