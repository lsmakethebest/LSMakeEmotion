//
//  AppDelegate.m
//  transparentExpression
//
//  Created by togo on 2017/6/7.
//  Copyright © 2017年 liusong. All rights reserved.
//



#import <SystemConfiguration/SystemConfiguration.h>
#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    // 必须写代理，不然无法监听通知的接收与点击
    center.delegate = self;
    //设置预设好的交互类型，NSSet里面是设置好的UNNotificationCategory
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus==UNAuthorizationStatusNotDetermined) {
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                } else {
                    
                }
            }];
        }
        else{
            //do other things
        }
    }];
    [[UIApplication sharedApplication]registerForRemoteNotifications];
    
    
    

    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://ydo.me/fds"];
    
    //2.创建一个请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 2.1设置请求方式
    // 注意: POST一定要大写
    request.HTTPMethod = @"POST";
    // 2.2设置请求体
    // 注意: 如果是给POST请求传递参数: 那么不需要写?号
    request.HTTPBody = [@"username=Mitchell&pwd=123456&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    

    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * __nullable response, NSData * __nullable data, NSError * __nullable connectionError) {
        NSLog(@"%@",connectionError);
        //4.解析服务器返回的数据
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //转换并打印响应头信息
        NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
    }];
    
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
   NSString *token= [NSString stringWithFormat:@"%@",deviceToken];
    token=[token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token=[token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token=[token stringByReplacingOccurrencesOfString:@">" withString:@""];
    [UIPasteboard generalPasteboard].string=token;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
