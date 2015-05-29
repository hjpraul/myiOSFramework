//
//  XFPBGHerLoadingView.m
//  Unionpay
//
//  Created by Qing Xiubin on 13-8-1.
//  Copyright (c) 2013年 成都中信联通科技有限公司. All rights reserved.
//

#import "XFPBGHerLoadingView.h"

#define TAG_LOADINGVIEW     181818
#define FONT_MESSAGE        [UIFont systemFontOfSize:15]
#define SIZE_ICON           20
#define SIZE_HEIGHT         40
#define SPACE_TO_CONTAINER  16
#define HV_SPACE            ((SIZE_HEIGHT-SIZE_ICON)/2)


@interface XFPBGHerLoadingView ()
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) UIImageView *statusImageView;
@property (retain, nonatomic) UIActivityIndicatorView *activity;
@property (nonatomic, retain) UILabel *messageLabel;
@end

@implementation XFPBGHerLoadingView

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //容器
        CGRect contentFrame = CGRectMake(0, 0, frame.size.width-SPACE_TO_CONTAINER*2, SIZE_HEIGHT);
        _contentView = [[UIView alloc] initWithFrame:contentFrame];
        [_contentView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_contentView];
        
        //状态图片
        CGRect statusFrame = CGRectMake(HV_SPACE,
                                        HV_SPACE,
                                        SIZE_ICON,
                                        contentFrame.size.height-HV_SPACE*2);
        _statusImageView = [[UIImageView alloc] initWithFrame:statusFrame];
        [_statusImageView setContentMode:UIViewContentModeCenter];
        [_contentView addSubview:_statusImageView];
        
        // Loading状态图片
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activity.center = CGPointMake(WIDTH(_statusImageView)/2, HEIGHT(_statusImageView)/2);
        [_activity startAnimating];
        _activity.hidden = YES;
        [_statusImageView addSubview:_activity];
        
        //提示信息
        CGRect messageFrame = CGRectMake(SIZE_ICON+20,
                                         10,
                                         contentFrame.size.width-(SIZE_ICON+30),
                                         contentFrame.size.height-20);
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
    
    CGRect statusFrame = CGRectMake(HV_SPACE+_contentView.bounds.origin.x,
                                    HV_SPACE,
                                    SIZE_ICON,
                                    _contentView.bounds.size.height-HV_SPACE*2);
    [_statusImageView setFrame:statusFrame];
    
    CGRect messageFrame = CGRectMake(statusFrame.origin.x+SIZE_ICON+HV_SPACE,
                                     HV_SPACE,
                                     _contentView.bounds.size.width-(SIZE_ICON+HV_SPACE*3),
                                     _contentView.bounds.size.height-HV_SPACE*2);
    [_messageLabel setFrame:messageFrame];
}

/**********************************************************************/
#pragma mark - Private Methods
/**********************************************************************/

+ (XFPBGHerLoadingView *)loadingViewInView:(UIView *)view{
    XFPBGHerLoadingView *loadingView = (XFPBGHerLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        loadingView = [[XFPBGHerLoadingView alloc] init];
        [loadingView setTag:TAG_LOADINGVIEW];
        [loadingView setFrame:view.bounds];
        [view addSubview:loadingView];
    }
    return loadingView;
}

+ (CGSize)contentSizeOfMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [message sizeWithFont:FONT_MESSAGE
                             constrainedToSize:CGSizeMake(WIDTH(view)-SPACE_TO_CONTAINER*2-SIZE_ICON-HV_SPACE*3, FONT_MESSAGE.pointSize)
                                 lineBreakMode:NSLineBreakByWordWrapping];
    contentSize.width = contentSize.width+SIZE_ICON+HV_SPACE*3;
    contentSize.height = (contentSize.height<(SIZE_HEIGHT-HV_SPACE*2)?(SIZE_HEIGHT-HV_SPACE*2):contentSize.height)+HV_SPACE*2;
    return contentSize;
}

/**********************************************************************/
#pragma mark - Puboic Methods
/**********************************************************************/

+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message inView:view];
    
    //设置内容
    XFPBGHerLoadingView *loadingView = [self loadingViewInView:view];
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
    XFPBGHerLoadingView *loadingView = [self loadingViewInView:view];
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
    XFPBGHerLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.contentView setFrame:CGRectMake((WIDTH(view)-contentSize.width)/2,
                                                 (HEIGHT(view)-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    [loadingView.statusImageView setImage:[UIImage imageNamed:@"loading_error"]];
    loadingView.activity.hidden = YES;
}


+ (void)hideInView:(UIView *)view animated:(BOOL)animated{
    XFPBGHerLoadingView *loadingView = (XFPBGHerLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
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
