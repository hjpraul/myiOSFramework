//
//  XFPPageCache.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/17.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef XFP_USE_TAB_HOME
#import "XFPTabHomeVC.h"
#endif

#define XFP_PAGE_CACHE  ([XFPPageCache sharedInstance])
@interface XFPPageCache : NSObject
AS_SINGLETON(XFPPageCache)

#ifdef XFP_USE_TAB_HOME
@property (strong, nonatomic) XFPTabHomeVC *homeVC;
#endif

@end
