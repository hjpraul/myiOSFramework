//
//  XFPBGLoadingView.m
//  Unionpay
//
//  Created by Qing Xiubin on 13-8-1.
//  Copyright (c) 2013年 成都中信联通科技有限公司. All rights reserved.
//

#import "XFPBGLoadingView.h"

#define TAG_LOADINGVIEW     181818
#define FONG_MESSAGE        [UIFont systemFontOfSize:15]
#define SIZE_ICON           40
#define SIZE_HEIGHT         40
#define SIZE_WIDTH          200


@interface XFPBGLoadingView ()
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) UIImageView *statusImageView;
@property (nonatomic, retain) UILabel *messageLabel;
@end

@implementation XFPBGLoadingView

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //容器
        CGRect contentFrame = CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT);
        _contentView = [[UIView alloc] initWithFrame:contentFrame];
        [_contentView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_contentView];
        
        //状态图片
        CGRect statusFrame = CGRectMake(0,0, SIZE_WIDTH, SIZE_ICON);
        _statusImageView = [[UIImageView alloc] initWithFrame:statusFrame];
        [_statusImageView setContentMode:UIViewContentModeCenter];
        [_contentView addSubview:_statusImageView];
        
        //提示信息
        CGRect messageFrame = CGRectMake(0,SIZE_ICON,SIZE_WIDTH,SIZE_HEIGHT-SIZE_ICON);
        _messageLabel = [[UILabel alloc] initWithFrame:messageFrame];
        [_messageLabel setBackgroundColor:[UIColor clearColor]];
        [_messageLabel setTextAlignment:NSTextAlignmentCenter];
        [_messageLabel setTextColor:[UIColor grayColor]];
        [_messageLabel setNumberOfLines:999999];
        [_messageLabel setFont:FONG_MESSAGE];
        [_contentView addSubview:_messageLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    CGRect statusFrame = CGRectMake(0,0, _contentView.bounds.size.width, SIZE_ICON);
    [_statusImageView setFrame:statusFrame];
    
    CGRect messageFrame = CGRectMake(0,SIZE_ICON+10,_contentView.bounds.size.width,_contentView.bounds.size.height-SIZE_ICON);
    [_messageLabel setFrame:messageFrame];
}

/**********************************************************************/
#pragma mark - Private Methods
/**********************************************************************/

+ (XFPBGLoadingView *)loadingViewInView:(UIView *)view{
    XFPBGLoadingView *loadingView = (XFPBGLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        loadingView = [[XFPBGLoadingView alloc] init];
        [loadingView setTag:TAG_LOADINGVIEW];
        [loadingView setFrame:view.bounds];
        [view addSubview:loadingView];
    }
    return loadingView;
}

+ (CGSize)contentSizeOfMessage:(NSString *)message{
    CGSize contentSize = [message sizeWithFont:FONG_MESSAGE
                             constrainedToSize:CGSizeMake(SIZE_WIDTH, 999999.0f)
                                 lineBreakMode:NSLineBreakByWordWrapping];
    contentSize.width = contentSize.width<SIZE_ICON?SIZE_ICON:contentSize.width;
    contentSize.height = contentSize.height+SIZE_ICON+10;
    return contentSize;
}

/**********************************************************************/
#pragma mark - Puboic Methods
/**********************************************************************/

+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message];
    CGSize frameSize = [[UIScreen mainScreen] bounds].size;
    frameSize.height -= 64;
    
    //设置内容
    XFPBGLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.statusImageView setImage:[UIImage animatedImageNamed:@"loading" duration:1.5f]];
    [loadingView.contentView setFrame:CGRectMake((frameSize.width-contentSize.width)/2,
                                                 (frameSize.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
}
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message];
    CGSize frameSize = [[UIScreen mainScreen] bounds].size;
    frameSize.height -= 64;
    
    //设置内容
    XFPBGLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.statusImageView setImage:[UIImage imageNamed:@"common_img_faildinfo"]];
    [loadingView.contentView setFrame:CGRectMake((frameSize.width-contentSize.width)/2,
                                                 (frameSize.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
}
+ (void)showNoInfoMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message];
    CGSize frameSize = [[UIScreen mainScreen] bounds].size;
    frameSize.height -= 64;
    
    //设置内容
    XFPBGLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.statusImageView setImage:[UIImage imageNamed:@"common_img_faildinfo"]];
    [loadingView.contentView setFrame:CGRectMake((frameSize.width-contentSize.width)/2,
                                                 (frameSize.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
}


+ (void)hideInView:(UIView *)view animated:(BOOL)animated{
    XFPBGLoadingView *loadingView = (XFPBGLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
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
