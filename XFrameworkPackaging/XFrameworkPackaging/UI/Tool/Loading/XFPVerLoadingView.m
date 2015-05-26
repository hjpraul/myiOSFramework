//
//  XFPVerLoadingView.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/5/25.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPVerLoadingView.h"
#define TAG_LOADINGVIEW     191918
#define FONT_MESSAGE        [UIFont systemFontOfSize:15]
#define SIZE_ICON           37  // UIActivityIndicatorViewStyleWhiteLarge的标准大小
#define SIZE_HEIGHT         95
#define HV_SPACE            ((SIZE_HEIGHT-15-SIZE_ICON)/3)

// 加载状态(1:加载中、2加载成功、3加载失败)
typedef NS_ENUM(NSInteger, XFPLoadingType) {
    kXFPLoadingTypeLoading = 1,
    kXFPLoadingTypeSuccess = 2,
    kXFPLoadingTypeFailed = 3,
};

@interface XFPVerLoadingView ()
@property (retain, nonatomic) UIView *contentView;
@property (retain, nonatomic) UIImageView *bgImageView;
@property (retain, nonatomic) UIActivityIndicatorView *activity;
@property (retain, nonatomic) UIImageView *statusImageView;
@property (retain, nonatomic) UILabel *messageLabel;
@property (assign, nonatomic) XFPLoadingType loadingType;
@end

@implementation XFPVerLoadingView

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //容器
        CGRect contentFrame = CGRectMake(0, 0, frame.size.width-HV_SPACE*2, SIZE_HEIGHT);
        _contentView = [[UIView alloc] initWithFrame:contentFrame];
        [self addSubview:_contentView];
        
        //背景图片
        CGRect bgFrame = _contentView.bounds;
        _bgImageView = [[UIImageView alloc] initWithFrame:bgFrame];
        _bgImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
        ViewRadius(_bgImageView, 6.0);
        [_contentView addSubview:_bgImageView];
        
        //状态图片
        CGRect statusFrame = CGRectMake(contentFrame.origin.x+SIZE_ICON/2,
                                        HV_SPACE,
                                        SIZE_ICON,
                                        SIZE_ICON);
        _statusImageView = [[UIImageView alloc] initWithFrame:statusFrame];
        [_statusImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_contentView addSubview:_statusImageView];
        
        // Loading状态图片
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_activity startAnimating];
        _activity.hidden = YES;
        [_statusImageView addSubview:_activity];
        
        //提示信息
        CGRect messageFrame = CGRectMake(contentFrame.origin.x+HV_SPACE,
                                         contentFrame.origin.y+HV_SPACE*2+SIZE_ICON,
                                         contentFrame.size.width-HV_SPACE*2,
                                         20);
        _messageLabel = [[UILabel alloc] initWithFrame:messageFrame];
        [_messageLabel setBackgroundColor:[UIColor clearColor]];
        [_messageLabel setTextAlignment:NSTextAlignmentCenter];
        [_messageLabel setTextColor:[UIColor whiteColor]];
        [_messageLabel setNumberOfLines:0];
        [_messageLabel setFont:FONT_MESSAGE];
        [_contentView addSubview:_messageLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    CGRect bgFrame = _contentView.bounds;
    [_bgImageView setFrame:bgFrame];
    
    CGRect statusFrame = CGRectMake(bgFrame.origin.x+(bgFrame.size.width-SIZE_ICON)/2,
                                    HV_SPACE,
                                    SIZE_ICON,
                                    SIZE_ICON);
    [_statusImageView setFrame:statusFrame];
    _activity.frame = _statusImageView.bounds;
    
    CGRect messageFrame = CGRectMake(bgFrame.origin.x+HV_SPACE,
                                     bgFrame.origin.y+HV_SPACE*2+SIZE_ICON,
                                     bgFrame.size.width-HV_SPACE*2,
                                     15);
    [_messageLabel setFrame:messageFrame];
}

/**********************************************************************/
#pragma mark - Private Methods
/**********************************************************************/

+ (instancetype)loadingViewInView:(UIView *)view{
    XFPVerLoadingView *loadingView = (XFPVerLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        loadingView = [[XFPVerLoadingView alloc] init];
        loadingView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.2f];
        [loadingView setTag:TAG_LOADINGVIEW];
        [loadingView setFrame:view.bounds];
        [view addSubview:loadingView];
    }
    return loadingView;
}

+ (CGSize)contentSizeOfMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [message sizeWithFont:FONT_MESSAGE
                             constrainedToSize:CGSizeMake(WIDTH(view)-HV_SPACE*2-SIZE_ICON-HV_SPACE*3, FONT_MESSAGE.pointSize)
                                 lineBreakMode:NSLineBreakByWordWrapping];
    contentSize.width = contentSize.width+HV_SPACE*2 < SIZE_HEIGHT ? SIZE_HEIGHT : contentSize.width+HV_SPACE*2;
    contentSize.height = SIZE_HEIGHT;
    return contentSize;
}

/**********************************************************************/
#pragma mark - Puboic Methods
/**********************************************************************/

+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message inView:view];
    
    //设置内容
    XFPVerLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.contentView setFrame:CGRectMake((WIDTH(view)-contentSize.width)/2,
                                                 (HEIGHT(view)-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    if (loadingView.loadingType != kXFPLoadingTypeLoading) {
        [loadingView setLoadingType:kXFPLoadingTypeLoading];
        [loadingView.statusImageView setImage:nil];
        loadingView.activity.hidden = NO;
    }
}
+ (void)showSuccessMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message inView:view];
    
    //设置内容
    XFPVerLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.contentView setFrame:CGRectMake((WIDTH(view)-contentSize.width)/2,
                                                 (HEIGHT(view)-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    if (loadingView.loadingType != kXFPLoadingTypeSuccess) {
        [loadingView setLoadingType:kXFPLoadingTypeSuccess];
        [loadingView.statusImageView setImage:[UIImage imageNamed:@"loading_success"]];
        loadingView.activity.hidden = YES;
    }
    
    //延迟隐藏
    [UIView animateWithDuration:0.2f delay:1.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [loadingView setAlpha:0];
    } completion:^(BOOL finished) {
        [loadingView removeFromSuperview];
    }];
}
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message inView:view];
    
    //设置内容
    XFPVerLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.contentView setFrame:CGRectMake((WIDTH(view)-contentSize.width)/2,
                                                 (HEIGHT(view)-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    if (loadingView.loadingType != kXFPLoadingTypeFailed) {
        [loadingView setLoadingType:kXFPLoadingTypeFailed];
        [loadingView.statusImageView setImage:[UIImage imageNamed:@"loading_error"]];
        loadingView.activity.hidden = YES;
    }
    
    //延迟隐藏
    [UIView animateWithDuration:0.2f delay:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [loadingView setAlpha:0];
    } completion:^(BOOL finished) {
        [loadingView removeFromSuperview];
    }];
}


+ (void)hideInView:(UIView *)view animated:(BOOL)animated{
    XFPVerLoadingView *loadingView = (XFPVerLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        return;
    }
    
    //隐藏动画
    if (animated) {
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [loadingView setAlpha:0];
        } completion:^(BOOL finished) {
            [loadingView removeFromSuperview];
        }];
    } else {
        [loadingView removeFromSuperview];
    }
}

@end
