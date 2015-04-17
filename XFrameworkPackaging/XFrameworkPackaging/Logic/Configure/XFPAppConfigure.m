//
//  XFPAppConfigure.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPAppConfigure.h"

#define APP_CONFIGURE_PATH PATH_OF_MAIN_BUNDLE(@"XFPAppConfigure")

@interface XFPAppConfigure ()
@property (strong, nonatomic) NSDictionary *fileContent;
@property (assign, nonatomic) NSInteger platform;   // 0:测试，1：正式
@end

@implementation XFPAppConfigure

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
