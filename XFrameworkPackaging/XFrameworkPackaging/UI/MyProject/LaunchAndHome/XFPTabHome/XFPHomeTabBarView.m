//
//  XFPHomeTabBarView.m
//  SchoolAxinPay
//
//  Created by zhax001 on 15/3/6.
//  Copyright (c) 2015年 zhax. All rights reserved.
//

#import "XFPHomeTabBarView.h"
@interface XFPHomeTabBarView ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tabBtns;
@end

@implementation XFPHomeTabBarView
// 只做样式，不做响应、动作
- (void)selectIndex:(NSInteger)index{
    for (int i = 0; i < _tabBtns.count; i++) {
        UIButton *btn = [_tabBtns objectAtIndex:i];
        if (i == index) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}
@end
