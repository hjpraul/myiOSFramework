//
//  XFPAppConfigure.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XFP_APP_CONFIGURE ([XFPAppConfigure shareInstance])

@interface XFPAppConfigure : NSObject
@property (strong, nonatomic) NSString *serverUrl;
@end
