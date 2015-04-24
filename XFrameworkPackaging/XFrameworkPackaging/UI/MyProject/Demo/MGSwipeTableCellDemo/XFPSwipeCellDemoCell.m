//
//  XFPSwipeCellDemoCell.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/20.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPSwipeCellDemoCell.h"
#import "MGSwipeButton.h"

@implementation XFPSwipeCellDemoCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setDataSource{
    self.rightButtons = @[[MGSwipeButton buttonWithTitle:@"测试1" icon:nil backgroundColor:[UIColor colorWithRed:255/255.0 green:110/255.0 blue:104/255.0 alpha:1]],
                          [MGSwipeButton buttonWithTitle:@"测试2" icon:nil backgroundColor:[UIColor colorWithRed:241/255.0 green:170/255.0 blue:0/255.0 alpha:1]]];
    self.rightSwipeSettings.transition = MGSwipeTransitionBorder;
    self.rightExpansion.threshold = MAXFLOAT;
}

@end
