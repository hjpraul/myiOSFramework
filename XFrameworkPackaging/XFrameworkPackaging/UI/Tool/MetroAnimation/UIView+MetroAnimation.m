//
//  UIView+Animation.m
//  MobileCRM
//
//  Created by hjpraul on 12/4/14.
//  Copyright (c) 2014 hjpraul. All rights reserved.
//

#import "UIView+MetroAnimation.h"

@implementation UIView (MetroAnimation)

- (void)metroLouverAnimateToView:(UIView *)toView
                             row:(NSInteger)row
                              lo:(NSInteger)lo
                       completed:(void (^)(void))completedBlock{
    // sorce view 转换成图片并切片
    UIImage *selfImg = [UIImage imageWithView:self];
    NSMutableArray *selfCrops = [NSMutableArray array];
    CGFloat selfCropWidth = selfImg.size.width/lo;
    CGFloat selfCropHeight = selfImg.size.height/row;
    UIView *selfContainer = [[UIView alloc] initWithFrame:self.frame];
    selfContainer.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < row*lo; i++) {
        int currRow = i/lo;
        int currLo = i%lo;
        UIImage *cropImg = [selfImg cropAtRect:CGRectMake(currLo*selfCropWidth, currRow*selfCropHeight, selfCropWidth, selfCropHeight)];
        UIImageView *crop = [[UIImageView alloc] initWithFrame:CGRectMake(currLo*selfCropWidth, currRow*selfCropHeight, selfCropWidth, selfCropHeight)];
        crop.image = cropImg;
        [selfCrops addObject:crop];
        [selfContainer addSubview:crop];
    }
    [self.superview addSubview:selfContainer];
    
    // sorce view 转换成图片并切片
    UIImage *toViewImg = [UIImage imageWithView:toView];
    NSMutableArray *toViewCrops = [NSMutableArray array];
    CGFloat toViewCropWidth = toViewImg.size.width/lo;
    CGFloat toViewCropHeight = toViewImg.size.height/row;
    UIView *toContainer = [[UIView alloc] initWithFrame:toView.frame];
    toContainer.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < row*lo; i++) {
        int currRow = i/lo;
        int currLo = i%lo;
        UIImage *cropImg = [toViewImg cropAtRect:CGRectMake(currLo*toViewCropWidth, currRow*toViewCropHeight, toViewCropWidth, toViewCropHeight)];
        UIImageView *crop = [[UIImageView alloc] initWithFrame:CGRectMake(currLo*toViewCropWidth, currRow*toViewCropHeight, toViewCropWidth, toViewCropHeight)];
        crop.image = cropImg;
        [toViewCrops addObject:crop];
        [toContainer addSubview:crop];
    }
    [self.superview addSubview:toContainer];
    
    // 视图初始位置设定
    for (int i = 0; i < row*lo; i++) {
        int currRow = i/lo;
        int currLo = i%lo;
        UIImageView *crop = [toViewCrops objectAtIndex:i];
        if (currRow%2) { // 向右
            crop.frame = CGRectMake(currLo*toViewCropWidth, currRow*toViewCropHeight, 0, toViewCropHeight);
            crop.contentMode = UIViewContentModeRedraw;
        } else { // 向左
            crop.frame = CGRectMake(currLo*toViewCropWidth+toViewCropWidth, currRow*toViewCropHeight, 0, toViewCropHeight);
            crop.contentMode = UIViewContentModeRedraw;
        }
    }
    for (int i = 0; i < row*lo; i++) {
        int currRow = i/lo;
        int currLo = i%lo;
        UIImageView *crop = [selfCrops objectAtIndex:i];
        if (currRow%2) { // 向右
            crop.frame = CGRectMake(currLo*selfCropWidth+selfCropWidth, currRow*selfCropHeight, 0, selfCropHeight);
            crop.contentMode = UIViewContentModeRedraw;
        } else { // 向左
            crop.frame = CGRectMake(currLo*selfCropWidth, currRow*selfCropHeight, 0, selfCropHeight);
            crop.contentMode = UIViewContentModeRedraw;
        }
    }
    toView.hidden = NO;
    
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
        for (int i = 0; i < row*lo; i++) {
            int currRow = i/lo;
            int currLo = i%lo;
            UIImageView *crop = [toViewCrops objectAtIndex:i];
            crop.frame = CGRectMake(currLo*toViewCropWidth, currRow*toViewCropHeight, toViewCropWidth, toViewCropHeight);
        }
        for (int i = 0; i < row*lo; i++) {
            int currRow = i/lo;
            int currLo = i%lo;
            UIImageView *crop = [selfCrops objectAtIndex:i];
            crop.frame = CGRectMake(currLo*selfCropWidth, currRow*selfCropHeight, selfCropWidth, selfCropHeight);
        }
    } completion:^(BOOL finished) {
        toView.frame = CGRectMake(X(self), Y(self), WIDTH(toView), HEIGHT(toView));
        [toContainer removeFromSuperview];
        [selfContainer removeFromSuperview];
        [self.superview addSubview:toView];
        [self removeFromSuperview];
        BLOCK_SAFE(completedBlock)();
    }];
}


- (void)metroMoveInAnimateToView:(UIView *)toView
                             row:(NSInteger)row
                              lo:(NSInteger)lo
                       completed:(void (^)(void))completedBlock{
    UIView *tempContainer = [[UIView alloc] initWithFrame:CGRectMake(-WIDTH(self), Y(self), WIDTH(self)*3, HEIGHT(self))];
    tempContainer.backgroundColor = [UIColor clearColor];
    
    // sorce view 转换成图片并切片
    UIImage *selfImg = [UIImage imageWithView:self];
    NSMutableArray *selfCrops = [NSMutableArray array];
    CGFloat selfCropWidth = selfImg.size.width/lo;
    CGFloat selfCropHeight = selfImg.size.height/row;
    for (int i = 0; i < row*lo; i++) {
        int currRow = i/lo;
        int currLo = i%lo;
        UIImage *cropImg = [selfImg cropAtRect:CGRectMake(currLo*selfCropWidth, currRow*selfCropHeight, selfCropWidth, selfCropHeight)];
        UIImageView *crop = [[UIImageView alloc] initWithFrame:CGRectMake(currLo*selfCropWidth+WIDTH(self), currRow*selfCropHeight, selfCropWidth, selfCropHeight)];
        crop.image = cropImg;
        [selfCrops addObject:crop];
        [tempContainer addSubview:crop];
    }
    
    // to view 转换成图片并切片
    UIImage *toViewImg = [UIImage imageWithView:toView];
    NSMutableArray *toViewCrops = [NSMutableArray array];
    CGFloat toViewCropWidth = toViewImg.size.width/lo;
    CGFloat toViewCropHeight = toViewImg.size.height/row;
    for (int i = 0; i < row*lo; i++) {
        int currRow = i/lo;
        int currLo = i%lo;
        UIImage *cropImg = [toViewImg cropAtRect:CGRectMake(currLo*toViewCropWidth, currRow*toViewCropHeight, toViewCropWidth, toViewCropHeight)];
        UIImageView *crop = [[UIImageView alloc] initWithFrame:CGRectMake(currLo*toViewCropWidth, currRow*toViewCropHeight, toViewCropWidth, toViewCropHeight)];
        if (currRow%2) { // 向右
            crop.frame = CGRectMake(currLo*selfCropWidth, currRow*selfCropHeight, toViewCropWidth, selfCropHeight);
        } else { // 向左
            crop.frame = CGRectMake(currLo*selfCropWidth+2*WIDTH(self), currRow*selfCropHeight, toViewCropWidth, selfCropHeight);
        }
        crop.image = cropImg;
        [toViewCrops addObject:crop];
        [tempContainer addSubview:crop];
    }
    [self.superview addSubview:tempContainer];
    toView.hidden = NO;
    
    UIView *tempView = [[UIView alloc] initWithFrame:self.bounds];
    tempView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tempView];
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
        for (int i = 0; i < row*lo; i++) {
            int currRow = i/lo;
            int currLo = i%lo;
            UIImageView *toViewCrop = [toViewCrops objectAtIndex:i];
            toViewCrop.frame = CGRectMake(currLo*selfCropWidth+WIDTH(self), currRow*selfCropHeight, selfCropWidth, selfCropHeight);
            
            UIImageView *selfCrop = [selfCrops objectAtIndex:i];
            if (currRow%2) { // 向右
                selfCrop.frame = CGRectMake(currLo*selfCropWidth+selfCropWidth+2*WIDTH(self), currRow*selfCropHeight, toViewCropWidth, selfCropHeight);
            } else { // 向左
                selfCrop.frame = CGRectMake(currLo*selfCropWidth-selfCropWidth, currRow*selfCropHeight, toViewCropWidth, selfCropHeight);
            }
        }
    } completion:^(BOOL finished) {
        toView.frame = CGRectMake(X(self), Y(self), WIDTH(toView), HEIGHT(toView));
        [tempContainer removeFromSuperview];
        [tempView removeFromSuperview];
        [self.superview addSubview:toView];
        [self removeFromSuperview];
        BLOCK_SAFE(completedBlock)();
    }];
}

- (void)metroMoveOutAnimateToView:(UIView *)toView
                           row:(NSInteger)row
                            lo:(NSInteger)lo
                     completed:(void (^)(void))completedBlock{
    UIView *tempContainer = [[UIView alloc] initWithFrame:CGRectMake(-WIDTH(self), Y(self), WIDTH(self)*3, HEIGHT(self))];
    tempContainer.backgroundColor = [UIColor clearColor];
    
    // sorce view 转换成图片并切片
    UIImage *selfImg = [UIImage imageWithView:self];
    NSMutableArray *selfCrops = [NSMutableArray array];
    CGFloat selfCropWidth = selfImg.size.width/lo;
    CGFloat selfCropHeight = selfImg.size.height/row;
    for (int i = 0; i < row*lo; i++) {
        int currRow = i/lo;
        int currLo = i%lo;
        UIImage *cropImg = [selfImg cropAtRect:CGRectMake(currLo*selfCropWidth, currRow*selfCropHeight, selfCropWidth, selfCropHeight)];
        UIImageView *crop = [[UIImageView alloc] initWithFrame:CGRectMake(currLo*selfCropWidth+WIDTH(self), currRow*selfCropHeight, selfCropWidth, selfCropHeight)];
        crop.image = cropImg;
        [selfCrops addObject:crop];
        [tempContainer addSubview:crop];
    }
    
    // to view 转换成图片并切片
    UIImage *toViewImg = [UIImage imageWithView:toView];
    NSMutableArray *toViewCrops = [NSMutableArray array];
    CGFloat toViewCropWidth = toViewImg.size.width/lo;
    CGFloat toViewCropHeight = toViewImg.size.height/row;
    for (int i = 0; i < row*lo; i++) {
        int currRow = i/lo;
        int currLo = i%lo;
        UIImage *cropImg = [toViewImg cropAtRect:CGRectMake(currLo*toViewCropWidth, currRow*toViewCropHeight, toViewCropWidth, toViewCropHeight)];
        UIImageView *crop = [[UIImageView alloc] initWithFrame:CGRectMake(currLo*toViewCropWidth, currRow*toViewCropHeight, toViewCropWidth, toViewCropHeight)];
        if (currRow%2) { // 向右
            crop.frame = CGRectMake(currLo*selfCropWidth+2*WIDTH(self), currRow*selfCropHeight, toViewCropWidth, selfCropHeight);
        } else { // 向左
            crop.frame = CGRectMake(currLo*selfCropWidth, currRow*selfCropHeight, toViewCropWidth, selfCropHeight);
        }
        crop.image = cropImg;
        [toViewCrops addObject:crop];
        [tempContainer addSubview:crop];
    }
    [self.superview addSubview:tempContainer];
    toView.hidden = NO;
    
    UIView *tempView = [[UIView alloc] initWithFrame:self.bounds];
    tempView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tempView];
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
        for (int i = 0; i < row*lo; i++) {
            int currRow = i/lo;
            int currLo = i%lo;
            UIImageView *toViewCrop = [toViewCrops objectAtIndex:i];
            toViewCrop.frame = CGRectMake(currLo*selfCropWidth+WIDTH(self), currRow*selfCropHeight, selfCropWidth, selfCropHeight);
            
            UIImageView *selfCrop = [selfCrops objectAtIndex:i];
            if (currRow%2) { // 向右
                selfCrop.frame = CGRectMake(currLo*selfCropWidth+selfCropWidth+2*WIDTH(self), currRow*selfCropHeight, toViewCropWidth, selfCropHeight);
            } else { // 向左
                selfCrop.frame = CGRectMake(currLo*selfCropWidth-selfCropWidth, currRow*selfCropHeight, toViewCropWidth, selfCropHeight);
            }
        }
    } completion:^(BOOL finished) {
        toView.frame = CGRectMake(X(self), Y(self), WIDTH(toView), HEIGHT(toView));
        [tempContainer removeFromSuperview];
        [tempView removeFromSuperview];
        [self.superview addSubview:toView];
        [self removeFromSuperview];
        BLOCK_SAFE(completedBlock)();
    }];
}

@end
