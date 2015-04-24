//
//  XFPPageCache.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/17.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>
#if XFP_USE_TAB_HOME
#import "XFPTabHomeVC.h"
#else
#import "XFPDemoHomeVC.h"
#endif

#define XFP_PAGE_CACHE  ([XFPPageCache sharedInstance])
@interface XFPPageCache : NSObject
AS_SINGLETON(XFPPageCache)

#if XFP_USE_TAB_HOME
@property (strong, nonatomic) XFPTabHomeVC *homeVC;
#else
@property (strong, nonatomic) XFPDemoHomeVC *homeVC;
#endif

@end
