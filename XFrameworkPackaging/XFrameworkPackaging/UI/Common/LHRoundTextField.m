//
//  LHRoundTextField.m
//  CHLightHandle
//
//  Created by hjpraul on 15/3/25.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "LHRoundTextField.h"

@implementation LHRoundTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, HEIGHT(self))];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    [self setBackground:[[UIImage imageNamed:@"bg_round_white"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch]];
}

@end
