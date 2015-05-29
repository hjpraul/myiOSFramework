//
//  UIView+Animation.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MetroAnimation)
- (void)metroLouverAnimateToView:(UIView *)toView
                             row:(NSInteger)row
                              lo:(NSInteger)lo
                       completed:(void (^)(void))completedBlock;

- (void)metroMoveInAnimateToView:(UIView *)toView
                             row:(NSInteger)row
                              lo:(NSInteger)lo
                       completed:(void (^)(void))completedBlock;

- (void)metroMoveOutAnimateToView:(UIView *)toView
                              row:(NSInteger)row
                               lo:(NSInteger)lo
                        completed:(void (^)(void))completedBlock;
@end
