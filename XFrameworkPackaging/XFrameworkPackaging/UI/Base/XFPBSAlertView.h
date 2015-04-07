//
//  XFPBSAlertView.h
//  LoveCook
//
//  Created by hjpraul on 13-8-18.
//  Copyright (c) 2013年 lovecook. All rights reserved.
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
