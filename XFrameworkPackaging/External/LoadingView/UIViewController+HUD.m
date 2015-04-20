//
//  XTViewController+HUD.m
//  ZrtCRM
//
//  Created by hjpraul on 13-5-24.
//  Copyright (c) 2014年 ZRT. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "LoadingView.h"

@implementation UIViewController (HUD)


#define BGLOADING_MAX_WIDTH     180
#define BGLOADING_MAX_HEIGHT    100
#define BGLOADING_ICON_WIDTH    44

/**********************************************************************/
#pragma mark - Create Methods
/**********************************************************************/

- (UIView *)loadingViewIn:(UIView *)view{
    UIView *loadingView = (UIView *)[view viewWithTag:1004109];
    if (loadingView == nil) {
        loadingView = [[UIView alloc] initWithFrame:CGRectZero];
        loadingView.backgroundColor = [UIColor clearColor];
        loadingView.tag = 1004109;
        [view addSubview:loadingView];
    }
    return loadingView;
}

- (UIImageView *)bgImageViewIn:(UIView *)view{
    UIImageView *bgImageView = (UIImageView *)[view viewWithTag:1000];
    if (bgImageView == nil) {
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        bgImageView.backgroundColor = [UIColor yellowColor];
        bgImageView.tag = 1000;
        [view addSubview:bgImageView];
    }
    return bgImageView;
}

- (UIImageView *)iconImageViewIn:(UIView *)view{
    UIImageView *iconImageView = (UIImageView *)[view viewWithTag:1001];
    if (iconImageView == nil) {
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        iconImageView.contentMode = UIViewContentModeCenter;
        iconImageView.backgroundColor = [UIColor clearColor];
        iconImageView.tag = 1001;
        [view addSubview:iconImageView];
    }
    return iconImageView;
}

- (UILabel *)messageLableIn:(UIView *)view{
    UILabel *messageLabel = (UILabel *)[view viewWithTag:1002];
    if (messageLabel == nil) {
        messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.numberOfLines = 9999;
        messageLabel.tag = 1002;
        [view addSubview:messageLabel];
    }
    return messageLabel;
}

/**********************************************************************/
#pragma mark - Show Methods
/**********************************************************************/

//HUD Methods
- (void)showBGLoading:(UIImage *)image message:(NSString *)message{
    UIFont *font = [UIFont boldSystemFontOfSize:16];
    
    CGSize loadingSize = [message sizeWithFont:font
                             constrainedToSize:CGSizeMake(BGLOADING_MAX_WIDTH-BGLOADING_ICON_WIDTH, font.pointSize)
                                 lineBreakMode:NSLineBreakByWordWrapping];
    loadingSize.width = loadingSize.width<BGLOADING_ICON_WIDTH?BGLOADING_ICON_WIDTH:loadingSize.width;
    loadingSize.height = loadingSize.height+BGLOADING_ICON_WIDTH;
    
    CGPoint center = CGPointMake(160, 188);
    if (isiPhone5) {
        center = CGPointMake(160, 232);
    }
    
    //添加Loading
    UIView *loadingView = [self loadingViewIn:self.view];
    [loadingView setFrame:CGRectMake(0, 0, loadingSize.width, loadingSize.height)];
    [loadingView setCenter:center];
    [loadingView bringSubviewToFront:self.view];
    
    //添加Icon
    UIImageView *iconImageView = [self iconImageViewIn:loadingView];
    [iconImageView setImage:image];
    [iconImageView startAnimating];
    [iconImageView setFrame:CGRectMake(0, 0, loadingSize.width, BGLOADING_ICON_WIDTH)];
    
    //添加Message
    UILabel *messageLabel = [self messageLableIn:loadingView];
    [messageLabel setTextAlignment:NSTextAlignmentCenter];
    [messageLabel setFont:font];
    [messageLabel setText:message];
    [messageLabel setFrame:CGRectMake(0, BGLOADING_ICON_WIDTH, loadingSize.width, loadingSize.height-BGLOADING_ICON_WIDTH)];
}

- (void)showBGIcon:(UIImage *)image message:(NSString *)message{
    UIFont *font = [UIFont boldSystemFontOfSize:14];
    
    CGSize loadingSize = [message sizeWithFont:font
                             constrainedToSize:CGSizeMake(BGLOADING_MAX_WIDTH-BGLOADING_ICON_WIDTH, font.pointSize)
                                 lineBreakMode:NSLineBreakByWordWrapping];
    loadingSize.width = loadingSize.width+BGLOADING_ICON_WIDTH;
    loadingSize.height = loadingSize.height<BGLOADING_ICON_WIDTH?BGLOADING_ICON_WIDTH:loadingSize.height;
    
    CGPoint center = CGPointMake(160, 188);
    if (isiPhone5) {
        center = CGPointMake(160, 232);
    }
    
    //添加Loading
    UIView *loadingView = [self loadingViewIn:self.view];
    [loadingView setFrame:CGRectMake(0, 0, loadingSize.width, loadingSize.height)];
    [loadingView setCenter:center];
    
    //添加Icon
    UIImageView *iconImageView = [self iconImageViewIn:loadingView];
    [iconImageView setImage:image];
    [iconImageView setFrame:CGRectMake(0, 0, BGLOADING_ICON_WIDTH, loadingSize.height)];
    
    //添加Message
    UILabel *messageLabel = [self messageLableIn:loadingView];
    [messageLabel setTextAlignment:NSTextAlignmentLeft];
    [messageLabel setFont:font];
    [messageLabel setText:message];
    [messageLabel setFrame:CGRectMake(BGLOADING_ICON_WIDTH, 0, loadingSize.width-BGLOADING_ICON_WIDTH, loadingSize.height)];
}
- (void)hideBG{
    UIView *loadingView = (UIView *)[self.view viewWithTag:1004109];
    if (loadingView != nil) {
        [loadingView removeFromSuperview];
    }
}


/**********************************************************************/
#pragma mark - Public Methods
/**********************************************************************/

//HUD Methods
- (void)showLoadingWithMessage:(NSString *)message{
    [LoadingView showLoadingMessage:message inView:self.view];
}

- (void)showSuccessWithMessage:(NSString *)message{
    [LoadingView showSuccessMessage:message inView:self.view];
}

- (void)showFailedWithMessage:(NSString *)message{
    [LoadingView showFailedMessage:message inView:self.view];
}

- (void)hideLoading{
    [LoadingView hideInView:self.view animated:YES];
}

//HUD Methods
- (void)showBGLoadingWithMessage:(NSString *)message{
    UIImage *image = [UIImage animatedImageNamed:@"loading" duration:1.2f];
    [self showBGLoading:image message:message];
}
- (void)showBGLoadFailedWithMessage:(NSString *)message{
    UIImage *image = [UIImage imageNamed:@"loadingError"];
    [self showBGIcon:image message:message];
}

- (void)showBGLoadEmptyWithMessage:(NSString *)message{
    UIImage *image = [UIImage imageNamed:@"loadingEmpty"];
    [self showBGIcon:image message:message];
}

- (void)hideBGLoading{
    [self hideBG];
}

@end
