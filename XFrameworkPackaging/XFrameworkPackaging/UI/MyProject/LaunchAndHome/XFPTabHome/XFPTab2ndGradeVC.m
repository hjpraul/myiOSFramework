//
//  XFPTab2ndGradeVC.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/17.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPTab2ndGradeVC.h"

@interface XFPTab2ndGradeVC ()

@end

@implementation XFPTab2ndGradeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"test";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (isIOS7Above) {
        self.navigationController.navigationBar.translucent = NO;
        self.tabBarController.tabBar.translucent = NO;
    }
    
    [XFP_PAGE_CACHE.homeVC hideCustomTabBar:YES];
}

@end
