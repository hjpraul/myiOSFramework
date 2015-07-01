//
//  XFPCommonDao.h
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/6/12.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "MJExtension.h"


@protocol XFPDaoModelDelegate <NSObject>
@required
- (void)model2DaoPretreat;
- (void)dao2ModelPretreat;
@end

@interface XFPCommonDao : NSObject
// 存储
+ (void)storeObjects:(NSArray *)objects
              toDBTB:(NSString *)tbNamePrefix;

// 载入
+ (NSArray *)loadObjectsFromDBTB:(NSString *)tbNamePrefix
                       className:(NSString *)className
                           range:(NSRange)range;
@end
