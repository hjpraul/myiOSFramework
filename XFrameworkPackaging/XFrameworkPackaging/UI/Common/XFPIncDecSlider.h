//
//  XFPIncDecSlider.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFPIncDecSlider : UIView
@property (copy, nonatomic) void (^incAction)(void);
@property (copy, nonatomic) void (^decAction)(void);
@end
