//
//  AppDelegate.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/2.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "AppDelegate.h"
#import "XFPLaunchVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self registerRemoteNotification];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    XFPLaunchVC *vc = [[UIStoryboard storyboardWithName:@"Launch" bundle:nil] instantiateInitialViewController];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}

#if XFP_NEED_REMOTE_NOTIFICATION
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    // 如果需要去掉deviceToken的空格及尖括号则去掉以下注释
//    NSString *tokenWithoutBracket = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    NSString *tokenWithoutBracketAndSpace = [tokenWithoutBracket stringByReplacingOccurrencesOfString:@" " withString:@""];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
    ///FIXME:推送消息处理
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    ///FIXME:推送消息及后台下载处理
}
#endif

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)registerRemoteNotification
{
    if (isIOS8Above) {
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    }
    
    UIRemoteNotificationType apnType = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apnType];
}

@end
