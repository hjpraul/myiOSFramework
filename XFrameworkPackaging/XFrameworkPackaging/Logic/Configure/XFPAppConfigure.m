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
@end

@implementation XFPAppConfigure

- (NSDictionary *)fileContent{
    if (!_fileContent) {
        _fileContent = [NSDictionary dictionaryWithContentsOfFile:APP_CONFIGURE_PATH];
    }
    
    return _fileContent;
}

- (NSString *)serverUrl{
    _serverUrl = [self.fileContent objectForKey:@"serverUrl"];
    return _serverUrl;
}

@end
