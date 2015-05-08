//
//  XFPBSPalette.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/5/6.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

///TODO:图片必须是固定大小，否则有问题，待优化完善！！！

@interface XFPBSPalette : UIImageView
@property (strong, nonatomic) UIColor *selectedColor;
@property (copy, nonatomic) void (^selectedColorChangedBlock)(UIColor *color);
@end
