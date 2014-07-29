//
//  MJAppDelegate.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-24.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "MJAppDelegate.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "ConfigKey.h"

@implementation MJAppDelegate
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return  [UMSocialSnsService handleOpenURL:url];
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (void)onMethod:(NSString *)method response:(NSDictionary *)data{
    if ([BPushRequestMethod_Bind isEqualToString:method])
    {
        NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
        
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        if (returnCode == BPushErrorCode_NetworkInvalible) {
            
        }
        NSLog(@"appid:%@--userid:%@--channelid:%@---requestid:%@--returnCode:%d",appid,userid,channelid,requestid,returnCode);
    }
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [BPush handleNotification:userInfo]; // 可选
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.applicationIconBadgeNumber = 1;
    notification.soundName= UILocalNotificationDefaultSoundName;
    notification.alertBody=@"您有新的面试消息";
    notification.alertAction = @"查看";
    notification.userInfo = userInfo;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    [notification release];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    
}
//如果推送通知注册成功，则自动调用这个方法。deviceToken 是什么？我估计应该是设备授权码吧
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"deviceToken: %@", deviceToken);
    [BPush registerDeviceToken:deviceToken]; // 必须
    NSString *pushToken = [[[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    NSLog(@"TokenString:%@",pushToken);
    //保存token
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:pushToken forKey:WKEY_DEVICES_TOKEN];
    [BPush bindChannel]; // 必须。可以在其它时机调用，只有在该方法返回（通过onMethod:response:回调）绑定成功时，app才能接收到Push消息。一个app绑定成功至少一次即可（如果access token变更请重新绑定）。
}
//对应的，失败就是：
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"注册推送服务时，发生以下错误： %@",error);
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Override point for customization after application launch.
    [UMSocialData setAppKey:@"53bcfc2056240bf0470623e7"];
    [UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:@"http://www.umeng.com/social"];
    [BPush setupChannel:launchOptions]; // 必须
    
    [BPush setDelegate:self]; // 必须。参数对象必须实现onMethod: response:方法，本示例中为self
    //注册推送
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
