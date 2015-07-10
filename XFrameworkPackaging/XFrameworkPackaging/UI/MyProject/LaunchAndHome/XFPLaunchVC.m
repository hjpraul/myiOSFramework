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
    
    if (![[XFPUserDefaults lastVersion] isEqualToString:APPVERSION]) {   // 新版本
        // 新版本初始化
        _splashBg.hidden = YES;
        _welcomScrollView.hidden = NO;
        [XFPUserDefaults setLastVersion];
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
    if (1) {
        UINavigationController *nav = XFP_PAGE_CACHE.homeVC.navigationController;
        if (!nav) {
            nav = [[UINavigationController alloc] initWithRootViewController:XFP_PAGE_CACHE.homeVC];
        }
        // 方法1：替换keywindow
//        [UIView transitionWithView:APP_DELEGATE.window duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionAllowAnimatedContent animations:^{
//            APP_DELEGATE.window.rootViewController = nav;
//        } completion:^(BOOL finished) {
//            BLOCK_SAFE(completedBlock)();
//        }];
        
        // 方法2：present
        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.navigationController presentViewController:nav animated:YES completion:^{
            BLOCK_SAFE(completedBlock)();
        }];
    }
}

#pragma mark - Action Method
- (IBAction)goTapped:(UITapGestureRecognizer *)sender {
    [self switchEntryCompleted:^{
        _splashBg.hidden = NO;
        _welcomScrollView.hidden = YES;
    }];
}
@end
