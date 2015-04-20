//
//  LoadingView.m
//  SchoolPalmUser
//
//  Created by hjpraul on 14-8-5.
//  Copyright (c) 2014年 hjpraul. All rights reserved.
//

#import "LoadingView.h"
#import "UIImage+Convert.h"

#define TAG_LOADINGVIEW     191919
#define FONT_MESSAGE        [UIFont systemFontOfSize:15]
#define SIZE_ICON           20
#define SPACE               8
#define MESSAGE_HEIGHT      20
#define SIZE_HEIGHT         (SPACE*4+SIZE_ICON+MESSAGE_HEIGHT)
#define SIZE_WIDTH          (Main_Screen_Width-20*2)

@interface LoadingView ()
@property (retain, nonatomic) UIView *contentView;
@property (retain, nonatomic) UIImageView *bgImageView;
@property (retain, nonatomic) UIImageView *statusImageView;
@property (retain, nonatomic) UIActivityIndicatorView *activity;
@property (retain, nonatomic) UILabel *messageLabel;
@property (assign, nonatomic) NSInteger loadingType;//(1:加载中、2加载成功、3加载失败)
@end

@implementation LoadingView

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //容器
        CGRect contentFrame = CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT);
        _contentView = [[UIView alloc] initWithFrame:contentFrame];
        [_contentView setBackgroundColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.4f]];
        [self addSubview:_contentView];
        
        //背景图片
        CGRect bgFrame = _contentView.bounds;
        _bgImageView = [[UIImageView alloc] initWithFrame:bgFrame];
        [_bgImageView setImage:[[[UIImage imageWithColor:[UIColor blackColor]] stretchableImageWithLeftCapWidth:5.0f topCapHeight:5.0f] roundedRectImageWithSize:_bgImageView.frame.size radius:5.0]];
        [_contentView addSubview:_bgImageView];
        
        //状态图片
        CGRect statusFrame = CGRectMake((SIZE_WIDTH-SIZE_ICON)/2,SPACE*2, SIZE_ICON, SIZE_ICON);
        _statusImageView = [[UIImageView alloc] initWithFrame:statusFrame];
        [_statusImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_contentView addSubview:_statusImageView];
        
        // Loading状态图片
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:_statusImageView.bounds];
        [_activity startAnimating];
        _activity.hidden = YES;
        [_statusImageView addSubview:_activity];
        
        //提示信息
        CGRect messageFrame = CGRectMake((SIZE_WIDTH-SIZE_ICON-contentFrame.size.width)/2,SPACE*3+SIZE_ICON,contentFrame.size.width-(SIZE_ICON+30),contentFrame.size.height-20);
        _messageLabel = [[UILabel alloc] initWithFrame:messageFrame];
        [_messageLabel setBackgroundColor:[UIColor clearColor]];
        [_messageLabel setTextAlignment:NSTextAlignmentCenter];
        [_messageLabel setTextColor:[UIColor whiteColor]];
        [_messageLabel setNumberOfLines:999999];
        [_messageLabel setFont:FONT_MESSAGE];
        [_contentView addSubview:_messageLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    CGRect bgFrame = _contentView.bounds;
    [_bgImageView setFrame:bgFrame];
    
    CGRect statusFrame = CGRectMake((_contentView.bounds.size.width-SIZE_ICON)/2,SPACE*2, SIZE_ICON, SIZE_ICON);
    [_statusImageView setFrame:statusFrame];
    _activity.frame = _statusImageView.bounds;
    
    CGRect messageFrame = CGRectMake(SPACE,SPACE*3+SIZE_ICON,_contentView.bounds.size.width-(SPACE*2),MESSAGE_HEIGHT);
    [_messageLabel setFrame:messageFrame];
}

/**********************************************************************/
#pragma mark - Private Methods
/**********************************************************************/

+ (instancetype)loadingViewInView:(UIView *)view{
    LoadingView *loadingView = (LoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        loadingView = [[LoadingView alloc] init];
        loadingView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.2f];
        [loadingView setTag:TAG_LOADINGVIEW];
        [loadingView setFrame:view.bounds];
        [view addSubview:loadingView];
    }
    return loadingView;
}

+ (CGSize)contentSizeOfMessage:(NSString *)message{
    CGSize contentSize = [message sizeWithFont:FONT_MESSAGE
                             constrainedToSize:CGSizeMake(SIZE_WIDTH-SIZE_ICON-30, SIZE_HEIGHT)
                                 lineBreakMode:NSLineBreakByWordWrapping];
    contentSize.width = contentSize.width+SPACE*2;
    contentSize.height = SIZE_HEIGHT;
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
    LoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.contentView setFrame:CGRectMake((frameSize.width-contentSize.width)/2,
                                                 (frameSize.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    if (loadingView.loadingType != 1) {
        [loadingView setLoadingType:1];
        [loadingView.statusImageView setImage:nil];
        loadingView.activity.hidden = NO;
    }
}
+ (void)showSuccessMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message];
    CGSize frameSize = [[UIScreen mainScreen] bounds].size;
    frameSize.height -= 64;
    
    //设置内容
    LoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.contentView setFrame:CGRectMake((frameSize.width-contentSize.width)/2,
                                                 (frameSize.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    if (loadingView.loadingType != 2) {
        [loadingView setLoadingType:2];
        [loadingView.statusImageView setImage:[UIImage imageNamed:@"loadingSuccess"]];
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
    CGSize contentSize = [self contentSizeOfMessage:message];
    CGSize frameSize = [[UIScreen mainScreen] bounds].size;
    frameSize.height -= 64;
    
    //设置内容
    LoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.contentView setFrame:CGRectMake((frameSize.width-contentSize.width)/2,
                                                 (frameSize.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    if (loadingView.loadingType != 3) {
        [loadingView setLoadingType:3];
        [loadingView.statusImageView setImage:[UIImage imageNamed:@"loadingError"]];
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
    LoadingView *loadingView = (LoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
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
