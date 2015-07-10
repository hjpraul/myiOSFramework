//
//  XFPGlobal.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/2.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#ifndef XFrameworkPackaging_XFPGlobal_h
#define XFrameworkPackaging_XFPGlobal_h

#import "AppDelegate.h"

/******************常用预定义*****************/
// 获取mainmundle中的文件
#define PATH_OF_MAIN_BUNDLE(fileName) [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName]
// 沙盒路径
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// 客户端版本号
#define APPVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APPBUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
// 客户端名称
#define APPNAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APPBUNDLEID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

// Frame 和坐标相关
// App Frame
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]
// App Frame Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width
// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height
// 坐标最大值、中间值、最小值
#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)
#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)
#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

// 系统控件默认高度
#define kStatusBarHeight        (20.f)
#define kTopBarHeight           (44.f)
#define kBottomBarHeight        (49.f)
#define kCellDefaultHeight      (44.f)
#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)

// self.view 默认起始位置Y
#define kSelfViewY      (isIOS7Above ? (kStatusBarHeight+kTopBarHeight):0)

// PNG JPG 图片路径
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 通过路径的方式加载图片
#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:NO];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:NO]

// 设备版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

// 系统名称
#define SystemName              ([[UIDevice currentDevice] systemName])

// 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])

// 判断是否是iOS7
#define isIOS7Above ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
#define isIOS8Above ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 8)

// 安全调用Block的方法
#undef	BLOCK_SAFE
#define BLOCK_SAFE(block)           if(block)block

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif

// ARC/非ARC预编译
#if __has_feature(objc_arc)
/** Compiling with ARC */
#else
/** Compiling without ARC */
#endif

#define SAFE_ADD_OBJ_OPTIONAL(params,val,key)    do{if(val){[params setObject:val forKey:key];}}while(0)
#define SAFE_GET_ARRAY_OBJECT(array,index) ((array.count)>(index)?[array objectAtIndex:index]:nil)
#define SAFE_PARSE_DICT(dict,key)   ([(dict)[(key)] class] == [NSNull class]) ? nil : (dict)[(key)]
#define NOT_NIL_STR(str)    (str == nil ? @"" : str)
#define APP_DELEGATE    ((AppDelegate*)[[UIApplication sharedApplication] delegate])
// 单例预定义
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (instancetype)sharedInstance; \
+ (void)distroyInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
static __class *__singleton__; \
+ (instancetype) sharedInstance { \
@synchronized (self) { \
if (__singleton__ == nil) { \
__singleton__ = [[self alloc] init]; \
} \
} \
return __singleton__; \
} \
+ (void)distroyInstance { \
__singleton__ = nil; \
}


// 常量预定义
#define DEFAULT_ANIMATION_DURATION  (0.5)

/******************全局可见头文件*****************/
#import "XFPConfig.h"
#import "DDLog.h"
#import "XFPBSVC.h"
#import "XFPBSNaVC.h"
#import "XFPPageCache.h"
#import "UIView+Loading.h"
#import "UIView+BGLoading.h"
#import "NSString+Toast.h"
#import "XFPUserDefaults.h"

/******************工具类*****************/
#import "UIImage+Create.h"
#import "UIImage+Process.h"

// DDLog 预定义
#define DEBUG 1
#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_INFO;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif

#endif
