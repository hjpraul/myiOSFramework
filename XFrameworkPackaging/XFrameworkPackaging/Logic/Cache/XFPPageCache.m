//
//  XFPPageCache.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/17.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPPageCache.h"

@implementation XFPPageCache
DEF_SINGLETON(XFPPageCache)

#ifdef XFP_USE_TAB_HOME
- (XFPTabHomeVC *)homeVC{
    if (!_homeVC) {
        _homeVC = [UIStoryboard storyboardWithName:@"XFPTabHome" bundle:nil].instantiateInitialViewController;
    }
    
    return _homeVC;
}
#endif
@end
