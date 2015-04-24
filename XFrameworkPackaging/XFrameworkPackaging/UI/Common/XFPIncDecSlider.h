//
//  XFPIncDecSlider.h
//  MobileCRM
//
//  Created by hjpraul on 12/3/14.
//  Copyright (c) 2014 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFPIncDecSlider : UIView
@property (copy, nonatomic) void (^incAction)(void);
@property (copy, nonatomic) void (^decAction)(void);
@end
