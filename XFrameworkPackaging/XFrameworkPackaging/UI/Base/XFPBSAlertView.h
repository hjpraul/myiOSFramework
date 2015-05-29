//
//  XFPBSAlertView.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

typedef NS_ENUM(NSInteger, AlertViewPresentationStyle){
	AlertViewPresentationStyleNone,
	AlertViewPresentationStylePop,
	AlertViewPresentationStyleFade,
	AlertViewPresentationStylePush,
};

typedef NS_ENUM(NSInteger, AlertViewDismissalStyle){
	AlertViewDismissalStyleNone,
	AlertViewDismissalStyleZoomIn,
	AlertViewDismissalStyleZoomOut,
	AlertViewDismissalStyleFade,
	AlertViewDismissalStylePush,
};

typedef NS_ENUM(NSInteger, AlertViewEnterDirection){
	AlertViewEnterDirectionFromTop,
	AlertViewEnterDirectionFromRight,
	AlertViewEnterDirectionFromBottom,
	AlertViewEnterDirectionFromLeft,
};

typedef NS_ENUM(NSInteger, AlertViewExitDirection){
	AlertViewExitDirectionToTop,
	AlertViewExitDirectionToRight,
	AlertViewExitDirectionToBottom,
	AlertViewExitDirectionToLeft,
};

#import <UIKit/UIKit.h>

@interface XFPBSAlertView : UIView
@property(nonatomic, assign) BOOL enableClickBGToDismiss;
@property(nonatomic, assign) AlertViewPresentationStyle presentationStyle;
@property(nonatomic, assign) AlertViewDismissalStyle dismissalStyle;
@property(nonatomic, assign) AlertViewEnterDirection enterDirection;
@property(nonatomic, assign) AlertViewExitDirection exitDirection;
@property(nonatomic, copy) void (^dismissBlock)(void);

- (void)show;
- (void)showWithStyle:(AlertViewPresentationStyle)presentationStyle;

- (void)dismiss;
- (void)dismissWithStyle:(AlertViewDismissalStyle)dismissalStyle;
@end
