//
//  XFPSinglePicPicker.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/20.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFPSinglePicPicker : NSObject
// 初始化函数，必须用此做初始化；maxSize<=0表示不做缩放
- (instancetype)initWithCompleted:(void(^)(UIImage *image))completedBlock
                          maxSize:(CGFloat)maxSize;

@end
