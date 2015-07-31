//
//  XFPLATDemoHomeVC.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/7/29.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPLATDemoHomeVC.h"
#import "XFPConfirmAlertView.h"

@interface XFPLATDemoHomeVC ()

@end

@implementation XFPLATDemoHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Method
- (IBAction)loadingBtnClicked:(UIButton *)sender {
    [self.view showLoadingWithMessage:@"test show loading"];
    [self.view performSelector:@selector(showFailedWithMessage:) withObject:@"test show failed loading" afterDelay:3.0f];
}

- (IBAction)alertBtnClicked:(UIButton *)sender {
    XFPConfirmAlertView *alert = [[[NSBundle mainBundle] loadNibNamed:@"XFPConfirmAlertView" owner:self options:nil] firstObject];
    [alert showWithNotice:@"test" sureAction:^{
        ;
    } cancelAction:^{
        ;
    }];
}

- (IBAction)toastBtnClicked:(UIButton *)sender {
    [@"test toast" toast];
}
@end
