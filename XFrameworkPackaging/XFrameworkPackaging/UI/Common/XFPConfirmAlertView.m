//
//  XFPConfirmAlertView.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPConfirmAlertView.h"

@interface XFPConfirmAlertView ()
@property (copy, nonatomic) void (^sureAction)(void);
@property (copy, nonatomic) void (^cancelAction)(void);
@property (weak, nonatomic) IBOutlet UILabel *notice;
@property (weak, nonatomic) IBOutlet UIImageView *bg;
@end

@implementation XFPConfirmAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.enableClickBGToDismiss = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.enableClickBGToDismiss = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Public Method
- (void)showWithNotice:(NSString *)notice
            sureAction:(void(^)(void))sureAction
          cancelAction:(void(^)(void))cancelAction{
    self.bg.image = [[UIImage imageNamed:@"bg_comm_alert"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    self.notice.text = notice;
    self.sureAction = sureAction;
    self.cancelAction = cancelAction;
    [self show];
}

#pragma mark - Private Method
- (void)cancelHandle{
    BLOCK_SAFE(_cancelAction)();
}

- (void)sureHandle{
    BLOCK_SAFE(_sureAction)();
}

#pragma mark - Action Method
- (IBAction)cancelBtnClicked:(UIButton *)sender {
    [self performSelector:@selector(cancelHandle) withObject:nil afterDelay:DEFAULT_ANIMATION_DURATION];
    [self dismiss];
}

- (IBAction)sureBtnclicked:(UIButton *)sender {
    [self performSelector:@selector(sureHandle) withObject:nil afterDelay:DEFAULT_ANIMATION_DURATION];
    [self dismiss];
}
@end
