//
//  XFPTabHomeVC.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/17.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPTabHomeVC.h"
#import "XFPHomeTabBarView.h"

@interface XFPTabHomeVC ()<UITabBarControllerDelegate>
@property (strong, nonatomic) XFPHomeTabBarView *customTabBar;
@end

@implementation XFPTabHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor clearColor] size:self.tabBar.frame.size];
    self.customTabBar = [[[NSBundle mainBundle] loadNibNamed:@"XFPHomeTabBarView" owner:self options:nil] firstObject];
    _customTabBar.frame = CGRectMake(0, HEIGHT(self.view)-HEIGHT(_customTabBar), WIDTH(self.view), HEIGHT(_customTabBar));
    [self.view addSubview:_customTabBar];
    [self.view bringSubviewToFront:self.tabBar];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];
}

- (void)hideCustomTabBar:(BOOL)isHide{
    _customTabBar.hidden = isHide;
}

#pragma mark - UITabBarController Delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    [_customTabBar selectIndex:index];
    return YES;
}

@end
