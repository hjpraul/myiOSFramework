//
//  XFPTab1stGradeVC.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/17.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPTab1stGradeVC.h"

@interface XFPTab1stGradeVC ()

@end

@implementation XFPTab1stGradeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBackButtonVisible:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (isIOS7Above) {
        self.navigationController.navigationBar.translucent = YES;
        self.tabBarController.tabBar.translucent = YES;
    }
    
    [XFP_PAGE_CACHE.homeVC hideCustomTabBar:NO];
}

@end
