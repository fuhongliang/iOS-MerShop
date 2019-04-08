//
//  AppDelegate.m
//  MerShop
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginInViewController.h"
#import "TabBarController.h"
#import "NavigationViewController.h"
#import <Bugtags/Bugtags.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //集成bugtags
    [Bugtags startWithAppKey:@"a9f3371df352d637e15d5cd13955a61c" invocationEvent:BTGInvocationEventBubble];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSString *token = [dict objectForKey:@"token"];
    if (token != nil){
        TabBarController *startVc = [TabBarController share];
        NavigationViewController *navi = [[NavigationViewController alloc]initWithRootViewController:startVc];
        [navi.navigationBar setHidden:YES];
        [self.window setRootViewController:navi];
    }else{
        LoginInViewController *login = [[LoginInViewController alloc]init];
        NavigationViewController *navi = [[NavigationViewController alloc]initWithRootViewController:login];
        [navi.navigationBar setHidden:YES];
        [self.window setRootViewController:navi];
    }
    
    return YES;
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
