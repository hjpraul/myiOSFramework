//
//  NSString+Formate.h
//  UnionSYF
//
//  Created by hjpraul on 14-4-23.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Formate)
// 获取格式化金额字符串（字体大小）
+ (NSAttributedString *)getFormatedAmountWithColor:(UIColor *)textColor
                                            amount:(NSString *)amount
                                              unit:(NSString *)unit;
//替换掉电话中某些特殊的字符
-(NSString *)toPurePhoneNum;


// 银行卡相关
// 普通字符串转换为银行卡安全形式 eg:6226222222222222222转换为6226 **** **** **** 2222
- (NSString *)toSecBankCardNum;

// 普通字符串转换为银行卡完整形式，eg:6226222222222222222转换为6226 2222 2222 2222 222
-(NSString *)toBankNum;

// 银行卡完整形式转换为普通字符串，eg:6226 2222 2222 2222 222转换为6226222222222222222
- (NSString *)bankCardNumToNormal;

// 标准传输时间转换成显示时间字符串（完整格式）  eg:20140102153033 ——> 2014-01-02 15:30:33
- (NSString *)toFullDateShow;

@end
