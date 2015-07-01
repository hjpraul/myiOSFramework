//
//  XFPAppConfigure.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPAppConfigure.h"

#define APP_CONFIGURE_PATH PATH_OF_MAIN_BUNDLE(@"XFPAppConfigure.plist")

static XFPAppConfigure *instance = nil;

@interface XFPAppConfigure ()
@property (strong, nonatomic) NSDictionary *fileContent;
@property (assign, nonatomic) NSInteger platform;   // 0:正式，1：测试
@end

@implementation XFPAppConfigure
+ (XFPAppConfigure *)shareInstance{
    if (!instance) {
        instance = [[XFPAppConfigure alloc] init];
        instance.platform = -1; // 首次需要获取
    }
    return instance;
}

- (NSInteger)platform{
    if (_platform < 0) {
        _platform = [[self.fileContent objectForKey:@"platform"] integerValue];
    }
    
    return _platform;
}

- (NSDictionary *)fileContent{
    if (!_fileContent) {
        _fileContent = [NSDictionary dictionaryWithContentsOfFile:APP_CONFIGURE_PATH];
    }
    
    return _fileContent;
}

- (NSString *)serverUrl{
    _serverUrl = SAFE_GET_ARRAY_OBJECT(((NSArray *)[self.fileContent objectForKey:@"serverUrl"]), self.platform);
    return _serverUrl;
}

@end
