//
//  XFPBGVerLoadingView.m
//  Unionpay
//
//  Created by Qing Xiubin on 13-8-1.
//  Copyright (c) 2013年 成都中信联通科技有限公司. All rights reserved.
//

#import "XFPBGVerLoadingView.h"

#define TAG_LOADINGVIEW     181817
#define FONT_MESSAGE        [UIFont systemFontOfSize:15]
#define SIZE_ICON           37  // UIActivityIndicatorViewStyleWhiteLarge的标准大小
#define SIZE_HEIGHT         95
#define HV_SPACE            ((SIZE_HEIGHT-15-SIZE_ICON)/3)


@interface XFPBGVerLoadingView ()
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) UIImageView *statusImageView;
@property (retain, nonatomic) UIActivityIndicatorView *activity;
@property (nonatomic, retain) UILabel *messageLabel;
@end

@implementation XFPBGVerLoadingView

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //容器
        CGRect contentFrame = CGRectMake(0, 0, frame.size.width-HV_SPACE*2, SIZE_HEIGHT);
        _contentView = [[UIView alloc] initWithFrame:contentFrame];
        [_contentView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_contentView];
        
        //状态图片
        CGRect statusFrame = CGRectMake(contentFrame.origin.x+SIZE_ICON/2,
                                        HV_SPACE,
                                        SIZE_ICON,
                                        SIZE_ICON);
        _statusImageView = [[UIImageView alloc] initWithFrame:statusFrame];
        [_statusImageView setContentMode:UIViewContentModeCenter];
        _statusImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_contentView addSubview:_statusImageView];
        
        // Loading状态图片
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activity.center = CGPointMake(WIDTH(_statusImageView)/2, HEIGHT(_statusImageView)/2);
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
        [_messageLabel setTextColor:[UIColor grayColor]];
        [_messageLabel setNumberOfLines:0];
        [_messageLabel setFont:FONT_MESSAGE];
        [_contentView addSubview:_messageLabel];
        
        self.backgroundColor = [UIColor redColor];
        _contentView.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)layoutSubviews{
    
    CGRect statusFrame = CGRectMake(_contentView.bounds.origin.x+(_contentView.bounds.size.width-SIZE_ICON)/2,
                                    HV_SPACE,
                                    SIZE_ICON,
                                    SIZE_ICON);
    [_statusImageView setFrame:statusFrame];
    
    CGRect messageFrame = CGRectMake(_contentView.bounds.origin.x+HV_SPACE,
                                     _contentView.bounds.origin.y+HV_SPACE*2+SIZE_ICON,
                                     _contentView.bounds.size.width-HV_SPACE*2,
                                     15);
    [_messageLabel setFrame:messageFrame];
}

/**********************************************************************/
#pragma mark - Private Methods
/**********************************************************************/

+ (XFPBGVerLoadingView *)loadingViewInView:(UIView *)view{
    XFPBGVerLoadingView *loadingView = (XFPBGVerLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        loadingView = [[XFPBGVerLoadingView alloc] init];
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
    XFPBGVerLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.contentView setFrame:CGRectMake((WIDTH(view)-contentSize.width)/2,
                                                 (HEIGHT(view)-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    
    [loadingView.statusImageView setImage:nil];
    loadingView.activity.hidden = NO;
}
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message inView:view];
    
    //设置内容
    XFPBGVerLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.contentView setFrame:CGRectMake((WIDTH(view)-contentSize.width)/2,
                                                 (HEIGHT(view)-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    [loadingView.statusImageView setImage:[UIImage imageNamed:@"loading_error"]];
    loadingView.activity.hidden = YES;
}
+ (void)showNoInfoMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message inView:view];
    
    //设置内容
    XFPBGVerLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.contentView setFrame:CGRectMake((WIDTH(view)-contentSize.width)/2,
                                                 (HEIGHT(view)-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    [loadingView.statusImageView setImage:[UIImage imageNamed:@"loading_error"]];
    loadingView.activity.hidden = YES;
}


+ (void)hideInView:(UIView *)view animated:(BOOL)animated{
    XFPBGVerLoadingView *loadingView = (XFPBGVerLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
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
