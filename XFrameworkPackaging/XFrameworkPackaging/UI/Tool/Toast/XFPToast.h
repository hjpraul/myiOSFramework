//
//  XFPToast.h
//  WePay
//
//  Created by hjpraul on 14-6-11.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WP_SHOWTOAST(str)   [XFPToast showWithText:str]

@interface XFPToast : NSObject{
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
}

+ (void)showWithText:(NSString *) text_;
+ (void)showWithText:(NSString *) text_
            duration:(CGFloat)duration_;

+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset_;
+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset
            duration:(CGFloat) duration_;

+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_;
+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_
            duration:(CGFloat) duration_;

@end
