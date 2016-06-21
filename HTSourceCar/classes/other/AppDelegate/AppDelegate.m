//
//  AppDelegate.m
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTabBarController.h"
#import "HTAccount.h"
#import "HTLogOnViewController.h"
#import "HTNavigationController.h"
#import <SMS_SDK/SMSSDK.h>
#import "XQNewFeatureVC.h"
#import "UIColor+Random.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1. 注册appkey及secret
    [SMSSDK registerApp:@"11b8ba61236da" withSecret:@"f97a7df541a12efb257d34d4054a1caa"];
    
    
    //创建窗口
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    HTTabBarController *tabbarVc = [[HTTabBarController alloc] init];
    
    //创建登录页面
    HTLogOnViewController *logVc = [[HTLogOnViewController alloc] init];
    HTNavigationController *logNav = [[HTNavigationController alloc] initWithRootViewController:logVc];
    
    //获取用户账号信息
    HTAccount *account = [HTAccountTool GetAcount];
    
    // 沙盒版本
    NSString *version =[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"version.data"]];
    // app当前版本
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    
    
    if ([currentVersion isEqualToString:version] && [account.accountid isEqualToString:@"1"]) {
        
        self.window.rootViewController = logNav;
        
    }else{
    
    XQNewFeatureVC *newVc = [[XQNewFeatureVC alloc] initWithFeatureImagesNameArray:@[@"引导页1",@"引导页2",@"引导页3"]];
    newVc.pageIndicatorTintColor = [UIColor randomColor];
    self.window.rootViewController = newVc;
    newVc.completeBlock = ^{
        self.window.rootViewController = logNav;
        
        // 保存当前版本
       [NSKeyedArchiver archiveRootObject:currentVersion toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"version.data"]];
        
        
    };
    
    }
    
//    //判断是否去主页
//    if (account) {//有账号
//        
//        _window.rootViewController = tabbarVc;
//        
//    }else{//没账号.去登录界面
//        
//        _window.rootViewController = logNav;
//        
//    }
    
    //主窗口可见
    [_window makeKeyAndVisible];
    
    return YES;
}

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

@end
