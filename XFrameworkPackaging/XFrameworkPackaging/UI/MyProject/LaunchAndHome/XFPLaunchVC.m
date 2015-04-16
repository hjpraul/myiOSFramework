//
//  XFPLaunchVC.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPLaunchVC.h"

@interface XFPLaunchVC ()
@property (weak, nonatomic) IBOutlet UIImageView *splashBg;
@property (strong, nonatomic) IBOutlet UIView *welcomContent;
@property (strong, nonatomic) IBOutlet UIScrollView *welcomScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoTopAlignConst;
@end

#define SPLASH_STAY_TIMEVAL (2)

@implementation XFPLaunchVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![XFP_LAST_VERSION isEqualToString:APPVERSION]) {   // 新版本
        // 新版本初始化
        _splashBg.hidden = YES;
        _welcomScrollView.hidden = NO;
    } else {
        _splashBg.hidden = NO;
        _welcomScrollView.hidden = YES;
        [self performSelector:@selector(switchEntryCompleted:) withObject:^{
            _splashBg.hidden = NO;
            _welcomScrollView.hidden = YES;
        } afterDelay:SPLASH_STAY_TIMEVAL];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)customViewDidLoad{
    _logoTopAlignConst.constant = 144*Main_Screen_Width/320;
}

#pragma mark - Private Method
- (void)switchEntryCompleted:(void(^)(void))completedBlock{
//    if (SAP_CLIENT_CACHE.userInfo.loginID.length > 0) {
//        if (!SAP_PAGE_CACHE.homeVC) {
//            SAP_PAGE_CACHE.homeVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateInitialViewController];
//        }
//        SAP_APP_DELEGATE.window.rootViewController = SAP_PAGE_CACHE.homeVC;
//        [SAP_APP_DELEGATE.window makeKeyAndVisible];
//        BLOCK_SAFE(completedBlock)();
//    } else {
//        UINavigationController *nav = SAP_PAGE_CACHE.loginHomeVc.navigationController;
//        if (!nav) {
//            if (!SAP_PAGE_CACHE.loginHomeVc) {
//                SAP_PAGE_CACHE.loginHomeVc = [[SAPLoginHomeVC alloc] init];
//            }
//            nav = [[SAPBSNaVC alloc] initWithRootViewController:SAP_PAGE_CACHE.loginHomeVc];
//        }
//        [UIView transitionWithView:SAP_APP_DELEGATE.window duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionAllowAnimatedContent animations:^{
//            SAP_APP_DELEGATE.window.rootViewController = nav;
//        } completion:^(BOOL finished) {
//            BLOCK_SAFE(completedBlock)();
//        }];
//    }
}

#pragma mark - Action Method
- (IBAction)goTapped:(UITapGestureRecognizer *)sender {
    [self switchEntryCompleted:^{
        _splashBg.hidden = NO;
        _welcomScrollView.hidden = YES;
    }];
}
@end
