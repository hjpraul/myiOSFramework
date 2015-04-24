//
//  UIView+Animation.h
//  MobileCRM
//
//  Created by hjpraul on 12/4/14.
//  Copyright (c) 2014 hjpraul. All rights reserved.
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
