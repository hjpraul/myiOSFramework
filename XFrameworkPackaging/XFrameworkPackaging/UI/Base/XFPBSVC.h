//
//  LHBSVC.h
//  CHLightHandle
//
//  Created by hjpraul on 15/1/17.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHBSVC : UIViewController
// 设置左边按钮
- (void)setLeftButtonWithTitle:(NSString *)title
                         image:(UIImage *)image
              highlightedImage:(UIImage *)hlImage
                         bgImg:(UIImage *)bgImage
            highlightedBgImage:(UIImage *)hlBgImage
                        action:(SEL)action;

// 设置返回按钮可见
- (void)setBackButtonVisible:(BOOL)isVisible;

// 设置右边按钮
- (void)setRightButtonWithTitle:(NSString *)title
                          image:(UIImage *)image
               highlightedImage:(UIImage *)hlImage
                          bgImg:(UIImage *)bgImage
             highlightedBgImage:(UIImage *)hlBgImage
                         action:(SEL)action;

// 返回按钮响应
- (void)bsBackBarClicked;

// 右边按钮响应
- (void)bsRightBarClicked;

// 用户自定义视图加载
- (void)customViewDidLoad;
@end
